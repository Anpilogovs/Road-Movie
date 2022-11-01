//
//  SearchViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
   
    private var searchController = UISearchController()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView!
    
    private var movies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearch()
        setUpTable()
//        fetchMovie()
        
    }

    
    private func setUpSearch() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchContainerView.addSubview(searchController.searchBar)
    }
    
    private func setUpTable() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    @IBAction func handelSegmentChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            NetworkRequest.shared.getMovies { result in
                switch result {
                case .success(let titles):
                    self.movies = titles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case 1:
            NetworkRequest.shared.getTvShow { result in
                switch result {
                case .success(let titles):
                    self.movies = titles
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break
        }
    }
    
    
//    private func fetchMovie() {
        
  
        
//        NetworkRequest.shared.getMovies { result in
//            switch result {
//            case .success(let titles):
//                self.movies = titles
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
//}


extension SearchViewController: UITableViewDelegate {
    
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let title =  movies[indexPath.row]
        let model = TitleViewModel(nameMovie: (title.original_title ?? title.original_name) ?? "", urlImage: title.poster_path ?? "")
        cell.configure(model: model)
        
        return cell
        
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        guard  let query = searchBar.text else { return }
        
        NetworkRequest.shared.search(query: query) { result in
            switch result {
            case .success(let title):
                self.movies = title
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {

}
