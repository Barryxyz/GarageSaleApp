//
//  LandingScreenViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/13/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LandingScreenViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //round corners of buttons
        loginButton.layer.cornerRadius = 10;
        loginButton.clipsToBounds = true;
        signUpButton.layer.cornerRadius = 10;
        signUpButton.clipsToBounds = true;
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAway)))


        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if (UsernameTextField.text!.isEmpty || PasswordTextField.text!.isEmpty){
            let alertController = UIAlertController(title: "Log In Error", message: "One of the fields is empty. Please enter values for all fields to log in.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        //if all fields populated, attempt to sign in; alert user if error is present
        else{
            Auth.auth().signIn(withEmail: UsernameTextField.text!, password: PasswordTextField.text!){ (user,error) in
                if (error == nil){
                    //programmatically make a connection (segue) to the tab bar home)
                    print(Auth.auth().currentUser!.uid)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarHome = storyBoard.instantiateViewController(withIdentifier: "tabBarHome")
                    self.present(tabBarHome, animated: true, completion: nil)
                }
                else {
                    let errorAlertController = UIAlertController(title: "Log In Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title:"OK", style: .cancel, handler: nil)
                    errorAlertController.addAction(defaultAction)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func onTapAway(sender: UITapGestureRecognizer){
        view.endEditing(true)
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
