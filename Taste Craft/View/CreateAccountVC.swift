//
//  CreateAccountVC.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-02-12.
//

import UIKit
import SwiftUI
import FirebaseAuth

class CreateAccountVC: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var invalidUsernameLabel: UILabel!
    @IBOutlet weak var invalidEmailLabel: UILabel!
    @IBOutlet weak var invalidPasswordLabel: UILabel!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    var isUsernameValid = false
    var isEmailValid = false
    var isPasswordValid = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidUsernameLabel.text = ""
        invalidEmailLabel.text = ""
        invalidPasswordLabel.text = ""
        
        createAccountButton.isEnabled = false
    }
    
    @IBAction func onUsernameTextFieldEdited(_ sender: UITextField) {
        if let username = usernameTextField.text{
            usernameCheck(username)
        }
    }
    
    @IBAction func onEmailTextFieldEdited(_ sender: UITextField) {
        if let email = emailTextField.text{
            if emailCheck(email){
                invalidEmailLabel.text = ""
                isEmailValid = true
                createAccountButtonState()
            } else {
                invalidEmailLabel.text = "Invalid Email"
                isEmailValid = false
                createAccountButtonState()
            }
        }
    }
    
    @IBAction func onPasswordTextFieldEdited(_ sender: UITextField) {
        
        if let password = passwordTextField.text{
            if passwordCheck(password){
                invalidPasswordLabel.text = ""
                isPasswordValid = true
                createAccountButtonState()
            } else {
                invalidPasswordLabel.text = "Invalid Password"
                isPasswordValid = false
                createAccountButtonState()
            }
        }
    }
    
    @IBAction func onCreateAccountButtonTapped(_ sender: UIButton) {
        print("CreateAccount button tapped")
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        authCheck(email: email, password: password)
    }
    
    
    //MARK: SEPARATE FUNCTIONS START HERE:
    
    func usernameCheck(_ username: String){
        if username.count < 3{
            invalidUsernameLabel.text = "Too few characters"
            isUsernameValid = false
            createAccountButtonState()
        } else if username.count > 12 {
            invalidUsernameLabel.text = "Too many characters"
            isUsernameValid = false
            createAccountButtonState()
        } else {
            invalidUsernameLabel.text = ""
            isUsernameValid = true
            createAccountButtonState()
        }
    }
    
    func emailCheck(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func passwordCheck(_ password: String) -> Bool {
        let minPasswordLength = 6
        return password.count >= minPasswordLength
    }
    
    func createAccountButtonState(){
        createAccountButton.isEnabled = isUsernameValid && isEmailValid && isPasswordValid
    }
    
    func authCheck(email: String, password: String){
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as? NSError {
                //            switch AuthErrorCode(rawValue: error.code) {
                //            case .operationNotAllowed:
                //              // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                //            case .emailAlreadyInUse:
                //              // Error: The email address is already in use by another account.
                //            case .invalidEmail:
                //              // Error: The email address is badly formatted.
                //            case .weakPassword:
                //              // Error: The password must be 6 characters long or more.
                //            default:
                //                print("Error: \(error.localizedDescription)")
                //            }
                
                print("Error: \(error.localizedDescription)")
            } else {
                print("User signs up successfully")
                let newUserInfo = Auth.auth().currentUser
                let email = newUserInfo?.email
                
                self.navigateToHomeScreen()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomeScreenVC"{
            let homeViewController = UIHostingController(rootView: HomeView())
            UIApplication.shared.windows.first?.rootViewController = homeViewController
        }
    }
    
    private func navigateToHomeScreen(){
        performSegue(withIdentifier: "goToHomeScreenVC", sender: self)
    }
    
    
}
