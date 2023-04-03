import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var customView: UIView!
    var detailView = DetailView.intanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.frame = customView.frame
        customView.addSubview(detailView)
       
        detailView.backButton.addTarget(self, action: #selector(backOnScreenButton), for: .touchUpInside)
    }
    
    @objc private func backOnScreenButton() {
        dismiss(animated: true)
    }
}
