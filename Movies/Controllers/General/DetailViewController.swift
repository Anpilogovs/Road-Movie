//
//  DetailViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 04.11.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var detailView = DetailView.intanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.frame = view.bounds
        view.addSubview(detailView)
        
        detailView.backButton.addTarget(self, action: #selector(backOnScreenButton), for: .touchUpInside)
    }
    
    @objc private func backOnScreenButton() {
        dismiss(animated: true)
    }
}
