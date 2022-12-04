//
//  FavoriteViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpTable()
    }
    
    
    private func  setUpTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    
}
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let title =  movies[indexPath.row]
        let model = TitleViewModel(nameMovie: (title.original_title ?? title.original_name) ?? "", urlImage: title.poster_path ?? "")
        cell.configure(model: model)
        
        return cell
        
    }
    
      
    
}
