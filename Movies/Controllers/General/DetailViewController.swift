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
        view.addSubview(detailView)
    }
    
   
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
