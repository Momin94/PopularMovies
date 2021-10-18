import Alamofire
import UIKit.UIImage

class MovieViewModel {
    // MARK: - Properties
    var movieArray = [MovieResults]()
    weak var movieViewController: ViewController?

    // MARK: - Methods
    func getMovie(callback: @escaping ([MovieResults]) -> Void) {
        let url = URL(string: "\(Constants.shareInstance.getBaseAPI())\(Constants.shareInstance.getAPIKey())\(Constants.shareInstance.getAPIParams())")!
        ApiService.shareInstance.getAllMovies(url: url) {
            model in
            if let movies = model.results {
                self.movieArray.append(contentsOf: movies)
            }
            callback(self.movieArray)
        }
    }

    func getCount() -> Int {
        return movieArray.count
    }
}
