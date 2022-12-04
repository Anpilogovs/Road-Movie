//
//  CollectionTableViewCell.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    weak var delegate: CollectionTableViewCellDelegate?
    
    static let identifier = "CollectionTableViewCell"
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
    
    func donwloadMovie(indexPath: IndexPath)  {
        CoreDataManager.shared.donwloadTitlewitch(model: movies[indexPath.row]) { result in
            switch result {
            case .success():
                print("donwloaded to Database")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
                guard let titleOverview = movies?.overview else { return }
                let detailModel = DetailViewModel(title: title, videoView:  videoElement, titleOverview: "Overview: \(titleOverview)")
                guard let selfStrong = self else { return }
                self?.delegate?.collectionTableViewDidTapCell(selfStrong, viewModel: detailModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config  = UIContextMenuConfiguration(identifier: nil,
                                                 previewProvider: nil) {[weak self] _ in
            let donwloadAction = UIAction(title: "Donwload", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.donwloadMovie(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [donwloadAction])
        }
        
        return config
    }
}
