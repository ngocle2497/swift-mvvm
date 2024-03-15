import Foundation
import Moya

enum API {
    case login
    case putFile
}

extension API: TargetType {
    var baseURL: URL {
        switch self {
        case .login:
            return URL(string: "https://domain.base.api")!
        case .putFile:
            return URL(string: "https://domain.file.api")!
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .putFile:
            return "/file"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        let parameters: [String: Any] = [:]
        let encoding: ParameterEncoding = URLEncoding.queryString
        switch self {
        case .login:
            return .requestParameters(parameters: parameters, encoding: encoding)
        case .putFile:
            return .requestParameters(parameters: parameters, encoding: encoding)
        }
    }
    
    var headers: [String : String]? {
        let defaultHeaders: [String: String] = ["Content-Type": "application/json"]
        switch self {
        case .login:
            return  defaultHeaders
        case .putFile:
            return ["Content-Type": "multipart/form-data"]
        }
    }
    
    
}
