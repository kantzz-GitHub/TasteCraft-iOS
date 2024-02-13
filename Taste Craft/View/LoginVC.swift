//
//  LoginVC.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-02-12.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
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
            invalidEmailLabel.text = "Invalid Email"
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
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomeScreenVC"{
            if let emailToDisplay = Auth.auth().currentUser?.email{
                let destination = segue.destination as! HomeScreenVC
                destination.userEmail = emailToDisplay
            }
        }
    }
    
    private func navigateToHomeScreen(){
        performSegue(withIdentifier: "goToHomeScreenVC", sender: self)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
