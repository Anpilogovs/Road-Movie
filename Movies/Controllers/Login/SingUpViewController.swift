//
//  SingUpViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 17.12.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SingUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
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
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
    
        Utilities.styleFilledButton(singUpButton)
    }
    
//    Check the fields and validate that the data is
//    correct. If everything is correct, this method
//    returns nil. Otherwise , it returns the error message
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if  firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            
            return "Please fill in all fields."
        }
        
        //Check if the password
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            //Password isn't secure enough
            return "Please make sure your password is at least 8 characters, containts a special character and a number"
        }
        
        return nil
    }
    
    @IBAction func singUpTapped(_ sender: Any) {
        //Validate the fields
        let error = validateFields()

        if error != nil {

            //There's something wrong with the fields, show error message
           showError(error!)
        }
        //Create cleaned versions of  the data
        let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        //Create the user
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            
            //Check for errors
            if  err != nil {
                
                //There was an error creating the user
                self.showError("Error creating user")
            } else {
                //User was created successfully, now store the first name and  las name
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstname": firstName,
                                                          "lastname": lastName,
                                                          "uid": result!.user.uid ])
                { (error) in

                    if error != nil {
                        //Show error message
                        self.showError("Error saving user data")
                    }
                }
                self.transitionToHome()
            }
        }
    }

    func showError(_ message: String)  {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    func transitionToHome()  {

      let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeViewController) as? HomeViewController 
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}