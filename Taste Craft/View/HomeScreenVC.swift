//
//  HomeScreenVC.swift
//  Taste Craft
//
//  Created by Shermukhammad Usmonov on 2024-02-12.
//

import UIKit
import FirebaseAuth

class HomeScreenVC: UIViewController {
    
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var userEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userEmailLabel.text = userEmail
    }
    
    
    @IBAction func onSignOutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out", signOutError)
        }
        
        
        dismiss(animated: true)
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
