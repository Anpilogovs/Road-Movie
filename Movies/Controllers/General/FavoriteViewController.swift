import UIKit
import RealmSwift

class FavoriteViewController: UIViewController {
//    MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
//    MARK: - var/let 
    var movies: [MovieTitleRealm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchLocalStorage()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"),
                                               object: nil, queue: nil) { _ in
            self.fetchLocalStorage()
        }
    }
    
    private func setUpTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.nib(),
                           forCellReuseIdentifier: FavoriteTableViewCell.identifier)
    }
    
    private func fetchLocalStorage() {
        RealmManager.shared.fetchingMovieFromDataBase { [unowned self] result in
            switch result {
            case .success(let movie):
                self.movies = movie
                DispatchQueue.main.async {
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 200
        return height
    }
}
// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        
        let title =  movies[indexPath.row]
        let model = TitleViewModel(nameMovie: title.original_title,
                                   urlImage: title.poster_path,
                                   description: title.overview,
                                   rating: title.vote_average)
        cell.configureFavoriteCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            guard indexPath.row < movies.count else { return }
            RealmManager.shared.deleteMovie(model: self.movies[indexPath.row]) { [unowned self] result in
                switch result {
                case .success():
                    print("Delete from the databae")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }
    }
}

