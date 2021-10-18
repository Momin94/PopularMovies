import Alamofire
import UIKit

class ApiService: NSObject {
    static let shareInstance = ApiService()

    func getAllMovies(url: URL, callback: @escaping (ResultModel) -> Void) {
        AF.request("\(Constants.shareInstance.getBaseAPI())\(Constants.shareInstance.getAPIKey())\(Constants.shareInstance.getAPIParams())").response { response in
            if let data = response.data {
                do {
                    let movieResponse = try JSONDecoder().decode(ResultModel.self, from: data)
                    callback(movieResponse)
                } catch let err {
                    print(err)
                }
            }
        }
    }
}
