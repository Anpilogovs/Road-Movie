//
//  DetailViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 04.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailView = DetailView.intanceFromNib()
    
    @IBOutlet weak var customView: UIView!
    
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
