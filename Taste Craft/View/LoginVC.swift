//
//  LoginVC.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-02-12.
//

import UIKit
import FirebaseAuth
import SwiftUI

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var invalidEmailLabel: UILabel!
    @IBOutlet weak var invalidPasswordLabel: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    var isEmailValid = false
    var isPasswordValid = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.isEnabled = false
        invalidEmailLabel.text = ""
        invalidPasswordLabel.text = ""
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        loginBtn.startAnimatingPressActions()

    }
    
    @IBAction func onEmailTextFieldChanged(_ sender: UITextField) {
        print("Email Value Changed")
        
        let emailText = sender.text ?? ""
        
        if(emailText.isEmpty){
            credentialsCheck(false)
        } else {
            credentialsCheck(true)
        }
    }
    
    @IBAction func onPasswordTextFieldChanged(_ sender: UITextField) {
        print("Password Value Changed")
        
        let passwordText = sender.text ?? ""
        
        if(passwordText.isEmpty){
            credentialsCheck(false)
        } else {
            credentialsCheck(true)
        }
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        print("loginBtnTapped")
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        authCheck(email: email, password: password)
        
    }
    
    // MARK: Functions to be separated start here
    
    func credentialsCheck(_ boolValue: Bool) {
        if boolValue == false{
            invalidEmailLabel.text = "Invalid Email OR"
            invalidPasswordLabel.text = "Invalid Password"
            isEmailValid = false
            isPasswordValid = false
            loginBtnState()
        } else {
            invalidEmailLabel.text = ""
            invalidPasswordLabel.text = ""
            isEmailValid = true
            isPasswordValid = true
            loginBtnState()
        }
    }
    
    func loginBtnState(){
        loginBtn.isEnabled = isEmailValid && isPasswordValid
    }
    
    func authCheck(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self](authResult, error) in
            guard let strongSelf = self else {
                return
            }
            
            if error != nil{
                print("Wrong email or password")
                //                strongSelf.emailTextField.text = ""
                strongSelf.passwordTextField.text = ""
                strongSelf.credentialsCheck(false)
                return
            }
            
            //            strongSelf.emailTextField.text = ""
            strongSelf.passwordTextField.text = ""
            strongSelf.navigateToHomeScreen()
            
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
            
            
            
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
}

extension UITextField {
  func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    
}


