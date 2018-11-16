//
//  MyProfileViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/15/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import FirebaseAuth

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var contactMethodTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutActionButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            //if there is no error and you have successfully signed out, send user back to main landing screen
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainLandingScreenVC = storyBoard.instantiateViewController(withIdentifier: "mainLandingScreen")
            self.present(mainLandingScreenVC, animated: true, completion: nil)
            
        }
        //otherwise catch error and display it as an alert back to user (and also in the console)
        catch let signOutError as NSError {
            print("There was an error when logging out: %@", signOutError)
            let alertController = UIAlertController(title: "Log Out Error", message: "There was an error when logging out, \(signOutError)", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
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
