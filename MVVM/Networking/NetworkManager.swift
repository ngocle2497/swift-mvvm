import Foundation
import Moya
import Alamofire

class APISession {
    typealias NetworkSession = Alamofire.Session
    
    static let session: NetworkSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(60)
        configuration.timeoutIntervalForResource = TimeInterval(60)
        let sessionManager = NetworkSession(configuration: configuration, eventMonitors: [])
        return sessionManager
    }()
}


class NetworkManager {
    static let shared = NetworkManager()
    
    func getAPIProvider<T: TargetType>(type: T.Type) -> MoyaProvider<T> {
        let plugins: [PluginType] =  []
        
        return MoyaProvider<T>(session: APISession.session, plugins: plugins)
    }
}

class CachePolicyPlugin: PluginType {
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var mutableRequest = request
        mutableRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return mutableRequest
    }
}
