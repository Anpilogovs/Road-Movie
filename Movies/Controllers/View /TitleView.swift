//
//  TitleView.swift
//  Movies
//
//  Created by Сергей Анпилогов on 24.03.2023.
//

import UIKit

class TitleView: UIView {
    
    @IBOutlet weak var titleImageView: UIImageView!
    
    func configureImage(model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.urlImage)") else { return }
        titleImageView.sd_setImage(with: url)
    }
    
    static func intanceFromNib() -> TitleView {
        return UINib(nibName: "DetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TitleView
    }
}
