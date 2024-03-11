import Foundation
import Alamofire

enum NetworkError: Error {
    case urlError
    case cannotParseData
}


struct NetworkReponse<T> {
    var data: T? = nil;
    var status: Bool = false;
    var message: String = ""
    init(data: T? = nil, status: Bool = true, message: String = ""){
        self.data = data ?? nil;
        self.status = status
        self.message = message
    }
}

struct RestFullApi<T: Codable>: Codable {
    let results: T
}

typealias CompleteHandleJSONCode<T> = (_ data: NetworkReponse<T>) -> Void
typealias Users = [UserModel]

struct Empty: Codable {
    
}

struct NetworkService {
    static let shared = NetworkService()
    
    private func request<T: Codable>(_ url: String,
                                     respType: T.Type = Empty.self,
                                     method: HTTPMethod = .get,
                                     parameters: [String:Any]? = nil,
                                     header: [String: String]? = nil,
                                     _ complete: @escaping CompleteHandleJSONCode<T>) -> Void {
        
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default , interceptor: .retryPolicy)
            .response { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(RestFullApi<T>.self, from: data!)
                        complete(NetworkReponse<T>(data: result.results))
                        
                    } catch {
                        complete(NetworkReponse(status: false, message: "Error parsing JSON: \(error)"))
                        print("Error parsing JSON: \(error)")
                    }
                case .failure(let error):
                    complete(NetworkReponse(status: false, message: "Api call failed: \(error)"))
                    
                    print(error)
                }
            }
    }
    
    func makeGet(url: String) {
        request(url) { data in
            if data.status {
                dump(data)
                print("Result")
            }
        }
    }
    
}
