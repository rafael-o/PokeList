//
//  AppProvider.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 28/04/22.
//

import Foundation
import Moya
import PromiseKit

class AppProvider<Target> where Target: TargetType {
    
    private let provider: MoyaProvider<Target>
    private let timeout = 60.0
    
    public init(stub: Bool = false) {
        
        /* Configurando as dependências requeridas para instanciar o Provider
         **/
        let endpointClosure = { (target: Target) -> Endpoint in
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        let requestClosure = MoyaProvider<Target>.defaultRequestMapping
        let stubClosure = stub ? MoyaProvider<Target>.delayedStub(1.3) : MoyaProvider<Target>.neverStub
        let sessionManager = MoyaProvider<Target>.defaultAlamofireSession()
        sessionManager.sessionConfiguration.timeoutIntervalForRequest = timeout
        
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: sessionManager)
    }
    
    func request(_ token: Target) -> Promise<Moya.Response> {
        return Promise { seal in
            self.request(token, seal: seal)
        }
    }
    
    private func request(_ token: Target, seal: Resolver<Response>) {
        do {
            provider.request(token, completion: { result in
                switch result {
                case let .success(response):
                    do {
                        _ = try response.filterSuccessfulStatusCodes()
                        self.handleWithSuccessResponse(response: response, seal: seal)
                    } catch {
                        self.handleWithResponseError(target: token, response: response, seal: seal)
                    }
                case let .failure(moyaError):
                    self.handleWithFailure(moyaError: moyaError, seal: seal)
                }
            })
        }
    }
    
    private func handleWithSuccessResponse(response: Response, seal: Resolver<Response>) {
        seal.fulfill(response)
    }
    
    private func handleWithResponseError(target: Target, response: Response, seal: Resolver<Response>) {
        if response.statusCode == 504 {
            seal.reject(AppError.timeoutError)
        } else {
            seal.reject(AppError.serverError(message: self.getMessageFromResponse(response), statusCode: response.statusCode))
        }
    }
    
    private func handleWithFailure(moyaError: MoyaError, seal: Resolver<Response>) {
        switch moyaError {
        case .underlying(let error as NSError, _):
            switch error.code {
            case -1004, -1009:
                seal.reject(AppError.serverError(message: "Não foi possível completar a operação. Verifique sua conexão com a Internet!", statusCode: error.code))
            default:
                seal.reject(AppError.serverError(message: "Não foi possível completar a operação.", statusCode: error.code))
            }
        default:
            seal.reject(AppError.networkError)
        }
    }
    
    private func getMessageFromResponse(_ response: Response) -> String {
        let message = try? response.map([String].self).joined(separator: "\n")
        if message == nil, let json = try? response.mapJSON() as? [String : String] , let message = json["Message"] {
            return message
        }
        return message ?? AppError.applicationError.localizedDescription
    }
}

// MARK: - Errors
public enum AppError: Error, LocalizedError {
    case serverError(message: String, statusCode: Int)
    case timeoutError
    case networkError
    case applicationError
    
    public var errorDescription: String? {
        switch self {
        case .serverError(let message, _):
            return message
        case .timeoutError:
            return "O tempo da solicitação esgotou. Por favor tente novamente mais tarde"
        case .networkError:
            return "Não foi possível completar a operação. Verifique sua conexão com a internet."
        case .applicationError:
            return "Um erro inesperado aconteceu, tente novamente mais tarde"
        }
    }
    
    public var statusCode: Int? {
        switch self {
        case .serverError(_, let statusCode):
            return statusCode
        default:
            return nil
        }
    }
}
