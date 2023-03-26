
import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [MovieTitleRealm] = [MovieTitleRealm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        fetchLocalStorage()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorage()
        }
    }
    
    private func  setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(SearchTableViewCell.nib(),
                           forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func fetchLocalStorage() {
        RealmManager.shared.fetchingMovieFromDataBase { [weak self] result in
            switch result {
            case .success(let movie):
                self?.movies = movie
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let title =  movies[indexPath.row]
        let model = TitleViewModel(nameMovie: (title.original_title ) ,
                                   urlImage: title.poster_path,
                                   description: title.overview,
                                   rating: "\(title.vote_average)")
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            guard indexPath.row < movies.count else { return }
            RealmManager.shared.deleteMovie(model: self.movies[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    print("Delete from the databae")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}

