//
//  SearchViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    
   
    @IBOutlet weak var searViewController: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        setUpTable()
        fetchMove()
        searViewController.delegate = self
    }
    
    func setUpTable() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
   private func fetchMove() {
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
    }
}

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

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
    }
}
