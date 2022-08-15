//
//  PokeTarget.swift
//  MVVM
//
//  Created by de Oliveira, Rafael on 27/04/22.
//

import Moya

enum PokeTarget {
    case getList(parameters: [String: Any])
    case getDetails(name: String)
}

extension PokeTarget: TargetType {
    
    var baseURL: URL {
        return try! AppSettings.Poke.baseUrl.asURL()
    }
    
    var path: String {
        switch self {
        case .getList:
            return AppSettings.Poke.path
        case .getDetails(let name):
            return AppSettings.Poke.path + "/\(name)"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .getList(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getDetails:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [String: String]()
    }
}
