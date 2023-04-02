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
    @IBOutlet weak var customView: UIView!
    
    static let identifier = "SearchTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        customView.addRoundedCornersAndBorder(cornerRadius: 10, borderWidth: 1, borderColor: .black)
        posterImage.addRoundedCornersAndBorder(cornerRadius: 10, borderWidth: 1, borderColor: .black)
    }
    
    func configure(model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.urlImage)") else { return }
        
        posterImage.sd_setImage(with: url)
        nameLabel.text = "Name: \(model.nameMovie)"
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




