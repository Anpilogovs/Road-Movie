//
//  CollectionTableViewCell.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionTableViewCell"
    
    var movies: [Movie] = [Movie]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        collectionView.register(UINib(nibName: "CollectionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    
    func configure(movie: [Movie]) {
        self.movies = movie
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate {
    
}

extension CollectionTableViewCell: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCollectionViewCell.identifier, for: indexPath) as? CollectionCollectionViewCell else { return UICollectionViewCell() }
        
        guard let posterPath = movies[indexPath.row].poster_path else  { return  UICollectionViewCell() }
      
        cell.setUpImage(model: posterPath)
        return cell
    }
}
