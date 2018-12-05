//
//  PasswordResetViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/15/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import FirebaseAuth

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAway)))


        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelActionButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        if (emailTextField.text!.isEmpty){
            let alertController = UIAlertController(title: "Reset Password Error", message: "Please enter an email to reset password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
                if (error == nil){
                    let alertController = UIAlertController(title: "Password Reset Success", message: "A password reset link has been sent to the entered email, \(self.emailTextField.text!)", preferredStyle: .alert)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainLandingScreenVC = storyBoard.instantiateViewController(withIdentifier: "mainLandingScreen")
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.present(mainLandingScreenVC, animated: true, completion: nil)})
                    alertController.addAction(defaultAction)
                    //self.present(mainLandingScreenVC, animated: true, completion: nil)
                    self.present(alertController, animated: true, completion: nil)
                }
                else{
                    let alertController = UIAlertController(title: "Password Reset Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
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
