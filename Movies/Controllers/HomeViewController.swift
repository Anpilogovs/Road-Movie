//
//  ViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 26.10.2022.
//

import UIKit

enum CategoryMovie: Int  {
    case Popular = 0
    case NowPlaying = 1
    case UpComing = 2
    case TopRated = 3
    
}

class HomeViewController: UIViewController {
    
    let sectionName: [String] = ["Popular", "NowPlaying", "UpComing", "TopRated"]
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTable()
    }

    
    
    
    
    private func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: CollectionTableViewCell.identifier)
    }

}





extension HomeViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionName[section]
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section  {
        case CategoryMovie.Popular.rawValue:
            NetworkRequest.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(movie: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
           
        
        default:
            return UITableViewCell()
        }
        
        return cell
    }
}
