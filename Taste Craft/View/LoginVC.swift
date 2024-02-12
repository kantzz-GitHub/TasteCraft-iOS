//
//  LoginVC.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-02-12.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var invalidEmailLabel: UILabel!
    @IBOutlet weak var invalidPasswordLabel: UILabel!
    
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.isEnabled = false
        invalidEmailLabel.text = ""
        invalidPasswordLabel.text = ""
    }
    
    @IBAction func onEmailTextFieldChanged(_ sender: UITextField) {
        
        print("Email Value Changed")
        
    }
    @IBAction func onPasswordTextFieldChanged(_ sender: UITextField) {
        print("Password Value Changed")
    }
    
    
    
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        print("loginBtnTapped")
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
