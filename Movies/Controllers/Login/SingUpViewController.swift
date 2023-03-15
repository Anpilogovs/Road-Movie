
import UIKit

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
        print(SignUpData.getUserData())
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
    
    func validateFields() -> String? {
        
        //Check that all fields are filled in
        if  firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""  {
            
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            let textErro = "Please make sure your password is at least 8 characters, containts a special character and a number"
            //Password isn't secure enough
            return textErro
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
        
        let signUpData = SignUpData(firstName: firstName, lastName: lastName, email: email, password: password)
        
        SignUpData.saveUserData(firstName: signUpData.firstName, lastName: signUpData.lastName, email: signUpData.email, password: signUpData.password)
        print(signUpData)
    }
    
    func showError(_ message: String)  {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome()  {
        
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constant.Storyboard.homeViewController) as? HomeViewController
    }
}
