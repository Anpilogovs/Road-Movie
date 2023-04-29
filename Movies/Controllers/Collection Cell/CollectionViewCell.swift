import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCollectionCell(model: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        
        movieImage.sd_setImage(with: url)
    }

}
