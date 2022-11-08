//
//  CollectionTableViewCell.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit

protocol CollectionTableViewCellDelegate: AnyObject {
    func collectionTableViewDidTapCell(_ cell: CollectionTableViewCell, viewModel: DetailViewModel)
}


class CollectionTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionTableViewCell"
    
    weak var delegate: CollectionTableViewCellDelegate?
    
   private var movies: [Movie] = [Movie]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    func configure(movie: [Movie]) {
        self.movies = movie
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
}

extension CollectionTableViewCell: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        guard let posterPath = movies[indexPath.row].poster_path else  { return  UICollectionViewCell() }
        
        cell.configure(model: posterPath)
        return cell
    }
}


extension CollectionTableViewCell: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        

        let titleName = movies[indexPath.row]
        guard let title = titleName.original_name ?? titleName.original_title else { return }
    
        NetworkRequest.shared.getMovie(query: title + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                print(videoElement)

                let movies = self?.movies[indexPath.row]
                guard let titleOverview = movies?.overview, let rating = movies?.vote_count else { return }
                
                let detailModel = DetailViewModel(title: "Name Movie: \(title)", videoView:  videoElement, titleOverview: "Overview: \(titleOverview)", rating: "Rating: \(rating)")
            
                guard let selfStrong = self else { return }
                self?.delegate?.collectionTableViewDidTapCell(selfStrong, viewModel: detailModel)
        
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
