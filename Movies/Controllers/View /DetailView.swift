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
    @IBOutlet weak var ratingLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    func configure(model: DetailViewModel) {
        self.titleMovieLabel.text = model.title
        self.overviewLabel.text = model.titleOverview
        self.ratingLabel.text = model.rating


        guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoView.id)") else { return }
        self.webView.load(URLRequest(url: url))

    }


    static func intanceFromNib() -> DetailView {
        return UINib(nibName: "DetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! DetailView
    }
}
