//
//  FavoriteTableViewCell.swift
//  Movies
//
//  Created by Сергей Анпилогов on 04.12.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var customFavoriteView: UIView!
    
    static let identifier = "FavoriteTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
        customFavoriteView.addRoundedCornersAndBorder(cornerRadius: 10, borderWidth: 1, borderColor: .black)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FavoriteTableViewCell", bundle: nil)
    }
    
    func configureFavoriteCell(model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.urlImage)") else { return }
        
        posterImage.sd_setImage(with: url)
        titleMovieLabel.text = "Name: \(model.nameMovie)"
        overviewLabel.text = "Overview:\n\(model.description)"
        ratingLabel.text = "Rating: \(model.rating)"
        ratingLabel.textColor = color(for: Double(model.rating) ?? 0)
    }
    
    private func color(for rating: Double) -> UIColor {
        switch rating {
        case 4.0...7.9:
            return .orange
        case 0...3.9:
            return .red
        case 8...10:
            return .green
        default:
            return .black
        }
    }
}




