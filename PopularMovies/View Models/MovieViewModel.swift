import Alamofire
import UIKit.UIImage

class MovieViewModel {
    // MARK: - Properties

    private var movieArray = [MovieCodable]()
    weak var movieViewController: ViewController?

    // MARK: - Methods

    func getMovie(callback: @escaping ([MovieCodable]) -> Void) {
        guard let url = URL(string: "\(Constants.shareInstance.getBaseAPI())\(Constants.shareInstance.getAPIKey())\(Constants.shareInstance.getAPIParams())") else {
            return
        }
        
        ApiService.shareInstance.getAllMovies(url: url) { response in
            if let movies = response.results {
                self.movieArray.append(contentsOf: movies)
            }
            callback(self.movieArray)
        } faliure: { errorMessage in
            print(errorMessage)
        }
    }

    func getCount() -> Int {
        return movieArray.count
    }
    
    func movieAt(index: Int) -> MovieCodable {
        return movieArray[index]
    }
}
