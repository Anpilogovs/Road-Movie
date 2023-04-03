import UIKit

enum CategoryMovie: Int  {
    case Popular = 0
    case UpComing = 1
    case TopRated = 2
}

class HomeViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainCustomView: UIView!
    //MARK: - var/let
    private let sectionName: [String] = ["Popular", "UpComing", "Top Rated"]
    private let mainTitleView = TitleView.intanceFromNib()
    private var movie: Movie?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeaderImageView()
        setUpTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainTitleView.movieImageView.addShadow()
    }

    private func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil),
                           forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.bounces = false
        mainTitleView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 500)
        tableView.tableHeaderView = mainTitleView
    }
    
    private func configureHeaderImageView() {
        
        NetworkRequest.shared.getPopupalMovies { [weak self] result in
            switch result {
            case .success(let title):
                let selected = title.randomElement()
                self?.movie = selected
                self?.mainTitleView.configure(model: TitleViewModel(nameMovie: "",
                                                                    urlImage: self?.movie?.poster_path ?? "",
                                                                    description: "",
                                                                    rating: ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
//MARK: UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else { return UITableViewCell() }
    
        cell.detailDelegate = self
        
        switch indexPath.section  {

        case CategoryMovie.Popular.rawValue:
            NetworkRequest.shared.getPopupalMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(movie: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case CategoryMovie.UpComing.rawValue:
            NetworkRequest.shared.getUpComingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(movie: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case CategoryMovie.TopRated.rawValue:
            NetworkRequest.shared.getTopRatedMovies { result in
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
//MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width, height: 30))
        label.text = sectionName[section]
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        headerView.addSubview(label)
        
        return headerView
    }
}
//MARK: CollectionTableViewCellDetailDelegate
extension HomeViewController: CollectionTableViewCellDetailDelegate {
    func collectionTableViewCellDidSelectItem(_ cell: CollectionTableViewCell, viewModel: DetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            guard let controller = self?.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
            controller.detailView.configureDetail(model: viewModel)
            controller.modalPresentationStyle = .fullScreen
            self?.present(controller, animated: true)
        }
    }
}
