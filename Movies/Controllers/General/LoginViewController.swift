//
//  LoginViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 17.12.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
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
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }

    @IBAction func loginTapped(_ sender: Any) {
        
//    TODO: Validate Text Fields
        
        //Created cleaned version of the next field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Singnin in the user
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                //Could't sing in
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeViewController) as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
