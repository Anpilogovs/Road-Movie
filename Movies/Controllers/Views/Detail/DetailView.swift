import UIKit
import WebKit

final class DetailView: UIView {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var upperImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configureDetail(model: DetailViewModel) {
        
        titleMovieLabel?.text = model.title
        overviewLabel?.text = model.titleOverview
        ratingLabel.text = "\(model.rating)/10"
        
        movieImageView.setImage(with: "https://image.tmdb.org/t/p/w500/\(model.urlImage)", alpha: 0.7)
        upperImageView.setImage(with: "https://image.tmdb.org/t/p/w500/\(model.urlImage)")
        guard let urlVideo = URL(string: "https://www.youtube.com/embed/\(model.videoView.id.videoId)") else { return }
        webView?.load(URLRequest(url: urlVideo))
    }

    static func intanceFromNib() -> DetailView {
        return UINib(nibName: "DetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DetailView
    }
}
