import Foundation
import RxSwift
import Moya
import Alamofire

struct BaseError: Error {
    let code: Int?
    let message: String?
}


class NetworkService {
    static func performApiNetworkCall<T: Codable>(route: API, type: T.Type) -> Observable<T> {
        return Observable.create { observer in
            NetworkManager.shared.getAPIProvider(type: API.self).request(route) { result in
                switch result {
                case .success(let response):
                    if response.statusCode == HttpStatusCode.OK.rawValue {
                        do {
                            let object = try JSONDecoder().decode(T.self, from: response.data)
                            observer.onNext(object)
                            observer.onCompleted()
                        } catch (let error) {
                            observer.onError(BaseError(code: response.statusCode, message: error.localizedDescription))
                        }
                    }
                case .failure(let error):
                    debugPrint(error)
                    observer.onError(BaseError(code: -1, message: error.localizedDescription))
                }
            }
            
            return Disposables.create()
        }
    }
}
