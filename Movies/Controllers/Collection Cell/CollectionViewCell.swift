//
//  CollectionCollectionViewCell.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.addRoundedCornersAndBorder(cornerRadius: 20,
                                            borderWidth: 4,
                                            borderColor: UIColor.black)

    }
    
    
    func configure(model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        
        movieImage.sd_setImage(with: url)
    }

}
