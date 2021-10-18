import SDWebImage
import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet var movieView: UICollectionView!
    var movieViewModel = MovieViewModel()
    private let sectionInsets = UIEdgeInsets(
        top: 30.0,
        left: 10.0,
        bottom: 30.0,
        right: 10.0)
    private let itemsPerRow: CGFloat = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        movieView.register(UINib(nibName: Constants.shareInstance.getCellName(),
                                 bundle: nil),
                           forCellWithReuseIdentifier: Constants.shareInstance.getCellName())

        movieViewModel.getMovie { _ in
            DispatchQueue.main.async {
                self.movieView.reloadData()
            }
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // 2
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return movieViewModel.getCount()
    }

    // 3
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.shareInstance.getCellName(),
            for: indexPath) as? MovieCell else {
                return UICollectionViewCell()
            }
        cell.backgroundColor = .darkGray
        if indexPath.row <= movieViewModel.movieArray.count {
            let modelMovie = movieViewModel.movieArray[indexPath.row]
            cell.movieTitle.text = modelMovie.title
            let imageURL = URL(string: "\(Constants.shareInstance.getBaseImageUrl())" + (modelMovie.poster_path ?? ""))
            cell.movieImage.sd_setImage(with: imageURL)
        }
        // Configure the cell
        return cell
    }

    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }

    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let destinationController = storyboard.instantiateViewController(withIdentifier: "moviedetail") as? MovieDetailsViewController else {
                    return
                }

                if indexPath.row <= movieViewModel.movieArray.count {
                    let movieModel = movieViewModel.movieArray[indexPath.row]
                    destinationController.movieModel = movieModel
                    navigationController?.show(destinationController, sender: self)
                }
            
    }
}
