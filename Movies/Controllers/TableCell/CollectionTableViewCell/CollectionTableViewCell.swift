//
//  CollectionTableViewCell.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    weak var detailDelegate: CollectionTableViewCellDetailDelegate?
    
    static let identifier = "CollectionTableViewCell"
    private var movies: [Movie] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
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
    
   private func donwloadMovie(indexPath: IndexPath)  {
        RealmManager.shared.donwloadTitlewitch(model: movies[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - UICollectionViewDataSource

extension CollectionTableViewCell: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        
        guard let posterPath = movies[indexPath.row].poster_path else  { return  UICollectionViewCell() }
        cell.configureCollectionCell(model: posterPath)
        cell.addRoundedCornersAndBorder(cornerRadius: 10, borderWidth: 2, borderColor: .black)
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension CollectionTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let title = movies[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        print(title)
        NetworkRequest.shared.getMovie(query: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                print(videoElement.id)
                let title = self?.movies[indexPath.row]
                guard let titleOverview = title?.overview else {
                    return
                }
                guard let selfStrong = self else {
                    return
                }
                let detailModel = DetailViewModel(urlImage: title?.poster_path ?? "",
                                                  title: titleName,
                                                  videoView: videoElement,
                                                  titleOverview: "Overview: \(titleOverview)",
                                                  rating: title?.vote_average ?? 10)
                self?.detailDelegate?.collectionTableViewCellDidSelectItem(selfStrong,
                                                                           viewModel: detailModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config  = UIContextMenuConfiguration(identifier: nil,
                                                 previewProvider: nil) {[weak self] _ in
            let donwloadAction = UIAction(title: "Donwload", subtitle: nil,
                                          image: nil, identifier: nil,
                                          discoverabilityTitle: nil,
                                          state: .off) { _ in
                self?.donwloadMovie(indexPath: indexPath)
            }
            return UIMenu(title: "", image: nil,
                          identifier: nil,
                          options: .displayInline,
                          children: [donwloadAction])
        }
        
        return config
    }
}
