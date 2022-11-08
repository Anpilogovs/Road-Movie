//
//  DetailViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 04.11.2022.
//

import UIKit

class DetailViewController: UIViewController {
    

    
    
    let customView =  DetailView.intanceFromNib()
    
    
    override func loadView() {
        super.loadView()
       
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpDetailView()
    }
    
    private func setUpDetailView() {
        let height: CGFloat = 0.8
        let y: CGFloat = 100
        customView.frame = CGRect(x: .zero, y: y, width: self.view.frame.width, height: self.view.frame.height * height)
        view.addSubview(customView)
    
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
