
import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView!
    
    private lazy var searchController = UISearchController()
    static let searchStoryboardId = "DetailViewController"
    public var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearch()
        setUpTable()
        fetchMovie()
    }
    
    private func setUpSearch() {
        searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchContainerView.addSubview(searchController.searchBar)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movie and tv"
        definesPresentationContext = true
    }
    
    private func setUpTable() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    @IBAction func handelSegmentChange(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            fetchMovie()
        case 1:
            fetchTvShow()
        default:
            break
        }
    }
    
    private func fetchMovie() {
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
    
    private func fetchTvShow() {
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
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let title =  movies[indexPath.row]
        let model = TitleViewModel(nameMovie: (title.original_title ?? title.original_name) ?? "", urlImage: title.poster_path ?? "", description: title.overview ?? "", rating: "\(title.vote_average)")
        cell.configure(model: model)
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = movies[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        NetworkRequest.shared.getMovie(query: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                print(videoElement)
                DispatchQueue.main.async {
                    let movies = self?.movies[indexPath.row]
                    guard let titleOverview = movies?.overview else { return }
                    guard  let controller =  self?.storyboard?.instantiateViewController(withIdentifier: SearchViewController.searchStoryboardId) as? DetailViewController else { return }
                    let detailModel = DetailViewModel(urlImage: movies?.poster_path ?? "",
                                                      title: titleName,
                                                      videoView:  videoElement, 
                                                      titleOverview: titleOverview, rating: movies?.vote_average ?? 0)
                    controller.detailView.configureDetail(model: detailModel)
                    self?.present(controller, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating, SearchResultViewControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        guard  let query = searchBar.text,
               !query.trimmingCharacters(in: .whitespaces).isEmpty,
               query.trimmingCharacters(in: .whitespaces).count >= 2,
               let searchResult = searchController.searchResultsController as? SearchResultViewController else { return }
        
        searchResult.delegate = self
        
        NetworkRequest.shared.searchMovies(query: query) { result in
            switch result {
            case .success(let title):
                DispatchQueue.main.async {
                    searchResult.movies = title
                    searchResult.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchResuldidTapToCell(viewModel: DetailViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            guard let controller =  self?.storyboard?.instantiateViewController(withIdentifier: SearchViewController.searchStoryboardId) as? DetailViewController else { return }
            controller.detailView.configureDetail(model: viewModel)
            self?.present(controller, animated: true)
        }
    }
}
