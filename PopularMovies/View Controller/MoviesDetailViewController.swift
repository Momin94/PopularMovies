import SDWebImage
import UIKit

class MovieDetailsViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieGenre: UILabel!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieOverview: UILabel!
    @IBOutlet var movieDate: UILabel!

    var imageText: String?
    var movieModel: MovieResults?

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        movieGenre?.text = movieModel?.vote_average?.description
        movieTitle?.text = movieModel?.title
        movieDate?.text = movieModel?.release_date
        movieOverview?.text = movieModel?.overview
        imageText = "\(Constants.shareInstance.getBaseImageUrl())" + "\(movieModel?.poster_path ?? "")"
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageURL = URL(string: imageText!)

        movieImage.sd_setImage(with: imageURL) { image, error, _, _ in
            if error != nil {
                // Failed to load image
                self.movieImage.image = UIImage(named: "TestImage.jpg")
            } else {
                // Successful in loading image
                self.movieImage.image = image
            }
        }
    }
}
