//
//  ViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 17.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    
    func setUpElements() {
        
        Utilities.styleFilledButton(singUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }
    
}
