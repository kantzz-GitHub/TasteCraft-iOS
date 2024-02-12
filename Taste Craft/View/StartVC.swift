//
//  ViewController.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-01-23.
//

import UIKit

class StartVC: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("loginTapped")
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        print("registerTapped")

    }
    
    
    
    
}

