//
//  LoginViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 17.12.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    
    func setUpElements() {
        
        //Hide the error label
        errorLabel.alpha = 0
        
        //Style the elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        
        Utilities.styleFilledButton(loginButton)
    }

    @IBAction func loginTapped(_ sender: Any) {
        
    }
}
