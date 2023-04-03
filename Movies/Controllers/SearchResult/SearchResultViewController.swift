//
//  SearchResultViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 11.11.2022.
//

import UIKit

class SearchResultViewController: UIViewController {
//  MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
//  MARK: - var/let
    weak var delegate: SearchResultViewControllerDelegate?
    var movies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollection()
    }
    
    private func  setUpCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
}
//MARK: - UICollectionViewDelegate
extension SearchResultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let title = movies[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name,
              let titleOverview = title.overview else { return }
        
        NetworkRequest.shared.getMovie(query: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                self?.delegate?.searchResuldidTapToCell(viewModel: DetailViewModel(
                    urlImage: title.poster_path ?? "",
                    title: titleName,
                    videoView: videoElement,
                    titleOverview: titleOverview,
                    rating: title.vote_average))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: - UICollectionViewDataSource
extension SearchResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell  else { return UICollectionViewCell() }
        
        let coverMove = movies[indexPath.row]
        cell.configureCollectionCell(model: coverMove.poster_path ?? "")
        return cell
    }
}
