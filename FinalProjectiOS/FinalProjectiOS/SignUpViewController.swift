//
//  SignUpViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/13/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //manages the pickerView for ContactMethod ("best contact method") text field
    
    let contactPickerData = [String](arrayLiteral: "Phone Call", "Email", "Text Message")
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contactPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contactPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ContactMethod.text = contactPickerData[row]
    }
    
    var ref:DatabaseReference!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cPassword: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var ContactMethod: UITextField!
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contactPicker = UIPickerView()
        ContactMethod.inputView = contactPicker
        contactPicker.delegate=self
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    //on Cancel, just go back to landing screen

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        if (password.text != cPassword.text) {
            let notMatchingAlert = UIAlertController(title: "Passwords do not match", message: "Please re-enter password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            notMatchingAlert.addAction(defaultAction)
            self.present(notMatchingAlert, animated: true, completion: nil)
        }
        else if (firstName.text!.isEmpty || lastName.text!.isEmpty || email.text!.isEmpty || password.text!.isEmpty || cPassword.text!.isEmpty || phoneNumber.text!.isEmpty || ContactMethod.text!.isEmpty){
            let alertController = UIAlertController(title: "Sign Up Error", message: "One of the fields is empty. Please enter values for all fields to sign up.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                //if there is no error
                if (error == nil){
                    //WRITE DATA TO FIREBASE DATABASE HERE
                    print(self.email.text!)
                    print(self.firstName.text!)
                    //use unique userID for user this will be assigned during login and used for user in future
                    print(Auth.auth().currentUser!.uid)
                    let userData = [ "firstName": self.firstName.text!,
                                     "lastName": self.lastName.text!,
                                     "email": self.email.text!,
                                     "password": self.password.text!,
                                     "contactMethod": self.ContactMethod.text!,
                                     "phoneNumber": self.phoneNumber.text!
                    ]
                    self.ref?.child("Users").child(Auth.auth().currentUser!.uid).setValue(userData)
                    
                    //programmatically make a connection (segue) to the tab bar home)
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let tabBarHome = storyBoard.instantiateViewController(withIdentifier: "tabBarHome")
                    self.present(tabBarHome, animated: true, completion: nil)
                }
                    // if there is an error, show that error
                else{
                    let errorAlertController = UIAlertController(title: "Sign Up Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title:"OK", style: .cancel, handler: nil)
                    errorAlertController.addAction(defaultAction)
                    self.present(errorAlertController, animated: true, completion: nil)
                }
            }
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
