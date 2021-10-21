import Alamofire
import UIKit

class ApiService: NSObject {
    static let shareInstance = ApiService()

    func decodableAPI<T: Decodable>(url: URL, success: @escaping (T) -> Void, faliure: @escaping (String) -> Void) {
        AF.request(url.absoluteString).response { response in
            if let data = response.data {
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    success(decodedObject)
                } catch let err {
                    faliure(err.localizedDescription)
                }
            }
        }
    }
    
    func getAllMovies(url: URL, success: @escaping (MoviesResponseCodable) -> Void, faliure: @escaping (String) -> Void) {
        ApiService.shareInstance.decodableAPI(url: url, success: success, faliure: faliure)
    }
}
