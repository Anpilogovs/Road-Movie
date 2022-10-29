//
//  CollectionCollectionViewCell.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit
import SDWebImage

class CollectionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionCollectionViewCell"
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func setUpImage(model: String) {
        guard let url = URL(string: "https/image.tmdb.org/t/p/w500/\(model)") else { return }
        
        movieImage.sd_setImage(with: url)
    }

}
