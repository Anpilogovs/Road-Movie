//
//  LoginViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 17.12.2022.
//

import UIKit

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
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let userData = SignUpData.getUserData()
        if email == userData.email ?? "" && password == userData.password ?? "" {
            transitionToHome()
        } else {
            // Неправильный email или пароль, показываем ошибку
            showError("Incorrect email or password.")
        }
    }
    
    func showError(_ message: String)  {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome()  {
        let tabBarController = UITabBarController()
        guard let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeViewController) else { return }
        tabBarController.viewControllers = [homeViewController]
        tabBarController.selectedIndex = 0
        tabBarController.modalPresentationStyle  = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
}
