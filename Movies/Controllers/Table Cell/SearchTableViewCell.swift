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
    
    static let identifier = "SearchTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
    
    
    func configure(model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.urlImage)") else { return }
        
        posterImage.sd_setImage(with: url)
        nameLabel.text = model.nameMovie
        
    }
}
