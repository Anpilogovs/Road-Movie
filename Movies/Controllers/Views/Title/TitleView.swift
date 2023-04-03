import UIKit
import SDWebImage


final class TitleView: UIView {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
        
    func configure(model: TitleViewModel) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.urlImage)") else { return }
        movieImageView.sd_setImage(with: url)
    }
    
    static func intanceFromNib() -> TitleView {
        return UINib(nibName: "TitleView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleView
    }
}

