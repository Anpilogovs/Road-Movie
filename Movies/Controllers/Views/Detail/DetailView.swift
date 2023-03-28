//
//  DetailView.swift
//  Movies
//
//  Created by Сергей Анпилогов on 04.11.2022.
//

import UIKit
import WebKit

class DetailView: UIView {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    func configure(model: DetailViewModel) {
            
        titleMovieLabel?.text = model.title
        overviewLabel?.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoView.id.videoId)") else { return }
        self.webView?.load(URLRequest(url: url))
    }
    
    func configureImage(model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.urlImage)") else { return }
        movieImageView.sd_setImage(with: url)
    }
    
    static func intanceFromNib() -> DetailView {
        return UINib(nibName: "DetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DetailView
    }
}
