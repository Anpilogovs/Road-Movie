//
//  SingUpViewController.swift
//  Movies
//
//  Created by Сергей Анпилогов on 17.12.2022.
//

import UIKit
import FirebaseAuth
import Firebase

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
        let cleanedPassworx = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassworx) == false {
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
        //Create the user
        Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>) { result, err in
            
            //Check for errors
            if  err != nil {
                //There was an error creating the user
                self.showError("Error creating user")
            } else {
                //User was created successfully, now store the first name and  las name
            
            }
        }
        
        //Transition to the home screen
    
    }
    
    
    func showError(_ message: String)  {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
}
