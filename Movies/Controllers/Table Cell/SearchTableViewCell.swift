//
//  SearchTableViewCell.swift
//  Movies
//
//  Created by Сергей Анпилогов on 30.10.2022.
//

import UIKit
class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    public var movies: [Movie] = [Movie]()
    
    static let identifier = "SearchTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.urlImage)") else { return }
        
        posterImage.sd_setImage(with: url)
        nameLabel.text = "Name: \(model.nameMovie)"
        overviewLabel.text = "Overview:\n\(model.description)"
        ratingLabel.text = "Rating: \(model.rating)"
    }
}

