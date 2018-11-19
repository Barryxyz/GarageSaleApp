//
//  MyProfileViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/15/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MyProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //manages the pickerView for contactMethodTextField ("best contact method")
    
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
        contactMethodTextField.text = contactPickerData[row]
    }
    
    var ref:DatabaseReference!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var contactMethodTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contactPicker = UIPickerView()
        contactMethodTextField.inputView = contactPicker
        contactPicker.delegate=self
        
        //don't allow editing of password text field, they must go to change password screen to change password
        passwordTextField.isUserInteractionEnabled = false
        passwordTextField.backgroundColor = UIColor.lightGray
        
        //start alert to load data
        let loadingAlert = UIAlertController(title: nil, message: "Loading Your Profile...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
        
        ref = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid)
        ref.observe(.value, with: { snapshot in
            let snapshotValue = snapshot.value as! NSDictionary
            let contactMethod = snapshotValue["contactMethod"]
            let email = snapshotValue["email"]
            let firstName = snapshotValue["firstName"]
            let lastName = snapshotValue["lastName"]
            let password = snapshotValue["password"]
            let phoneNumber = snapshotValue["phoneNumber"]
            
            //used as? so we can handle nils
            self.firstNameTextField.text = firstName as? String
            self.lastNameTextField.text = lastName as? String
            self.contactMethodTextField.text = contactMethod as? String
            self.emailTextField.text = email as? String
            self.phoneNumberTextField.text = phoneNumber as? String
            self.passwordTextField.text = password as? String
            
            //dismissing the alert after retrieving data from firebase
            loadingAlert.dismiss(animated: false, completion: nil)
        })

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveChangesAction(_ sender: Any) {
        //if any of the fields are empty, do NOT let the user save their input to the database
        if (firstNameTextField.text!.isEmpty || lastNameTextField.text!.isEmpty || contactMethodTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty || phoneNumberTextField.text!.isEmpty){
            let alertController = UIAlertController(title: "Save Changes Error", message: "One of the fields is empty. Please enter values for all fields before saving.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else{
            ref = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid)
            ref.updateChildValues(["contactMethod": contactMethodTextField.text!, "email": emailTextField.text!, "firstName": firstNameTextField.text!, "lastName": lastNameTextField.text!, "phoneNumber": phoneNumberTextField.text!])
            //present alert to tell user they have saved changes successfully
            let alertController = UIAlertController(title: "Saved Changes", message: "You have successfully saved your profile changes.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
       
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
