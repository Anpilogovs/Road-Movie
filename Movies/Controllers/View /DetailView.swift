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
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
   
    func configure(model: DetailViewModel) {
        
            self.titleMovieLabel?.text = model.title
            self.overviewLabel?.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoView.id.videoId)") else { return }
            self.webView?.load(URLRequest(url: url))
    }
    
    static func intanceFromNib() -> DetailView {
        return UINib(nibName: "DetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DetailView
    }
}
