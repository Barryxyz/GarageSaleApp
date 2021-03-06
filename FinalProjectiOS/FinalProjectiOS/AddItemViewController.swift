//
//  AddItemViewController.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/19/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import FirebaseAuth


var currItemDict: [String:String] = ["itemName": "", "price": "", "category": "", "description": "", "itemID": "", "streetAddr": "",
                                     "city": "", "state": "", "zipCode": "", "finalStringAddr": ""]

class AddItemViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var infoProgressBar: UIProgressView!
    
    var ref:DatabaseReference!
    var ref2:DatabaseReference!

    //sets up picker view for categoryTextField
    
    let contactPickerData = [String](arrayLiteral:"Furniture", "School", "Clothes", "Other")
    
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
        categoryTextField.text = contactPickerData[row]
    }
    
 
    
    
    override func viewDidLoad() {
        
//        currItemDict["itemName"] = ""
//        currItemDict["price"] = ""
//        currItemDict["category"] = ""
//        currItemDict["description"] = ""
//        currItemDict["itemID"] = ""
//        currItemDict["streetAddr"] = ""
//        currItemDict["city"] = ""
//        currItemDict["state"] = ""
//        currItemDict["zipCode"] = ""
//        currItemDict["finalStringAddr"] = ""
        //preset values if they exist
        itemNameTextField.text = currItemDict["itemName"]
        priceTextField.text = currItemDict["price"]
        categoryTextField.text = currItemDict["category"]
        descriptionTextView.text = currItemDict["description"]
        //places a border around the textview (which by default, doesn't have one)
        self.descriptionTextView.layer.borderWidth = 0.5
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.cornerRadius = 7
        let contactPicker = UIPickerView()
        categoryTextField.inputView = contactPicker
        contactPicker.delegate=self
        //set corners for the progress bar so it's not directly connected to the edges and also make it larger so it is more visible to user
        infoProgressBar.layer.cornerRadius = 7
        infoProgressBar.clipsToBounds = true
        infoProgressBar.transform = infoProgressBar.transform.scaledBy(x: 1.0, y: 4.0)
        infoProgressBar.progress = 0.333333333333333333
        //connect to Firebase
        ref = Database.database().reference()
        ref2 = Database.database().reference()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAway)))
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clearActionButton(_ sender: Any) {
        itemNameTextField.text = ""
        priceTextField.text = ""
        categoryTextField.text = ""
        descriptionTextView.text = ""
    }
    
    @IBAction func nextActionTwo(_ sender: Any) {
        if (itemNameTextField.text!.isEmpty || priceTextField.text!.isEmpty || categoryTextField.text!.isEmpty || descriptionTextView.text!.isEmpty){
            let alertController = UIAlertController(title: "Post Item Error", message: "One of the fields is empty. Please enter values for all fields to move to the next step.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if (priceTextField.text!.contains("$")){
            let alertController = UIAlertController(title: "Post Item Error", message: "Please enter only numbers in the price field, (e.g. 25, not $25).", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            //allow users to post items with the same ITEM NAME but the same user may NOT post the same item name twice
//            ref = Database.database().reference().child("Items").child(itemNameTextField.text!)
//            ref.observe(.value, with: { snapshot in
//                if (snapshot.exists()){
//                    let snapshotValue = snapshot.value as! NSDictionary
//                    let userPosted = snapshotValue["userPosted"] as! String
//                    let itemName = snapshotValue["itemName"] as! String
//                    if (itemName == self.itemNameTextField.text! && userPosted == Auth.auth().currentUser!.uid){
//                        let alertController = UIAlertController(title: "Post Item Error", message: "You have already posted an item with this name.  Please use a unique name for your item.", preferredStyle: .alert)
//                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                        alertController.addAction(defaultAction)
//                        self.present(alertController, animated: true, completion: nil)
//                    }
//                }
//            })
            let itemData = [ "itemName": self.itemNameTextField.text!,
                             "itemPrice": "$"+self.priceTextField.text!,
                             "itemCategory": self.categoryTextField.text!,
                             "itemDescription": self.descriptionTextView.text!,
                             "userPosted": Auth.auth().currentUser!.uid
            ]
            currItemDict["itemName"] = self.itemNameTextField.text!
            currItemDict["price"] = "$"+self.priceTextField.text!
            currItemDict["category"] = self.categoryTextField.text!
            currItemDict["description"] = self.descriptionTextView.text!

            self.ref?.child("Items").child(itemNameTextField.text! + Auth.auth().currentUser!.uid).setValue(itemData)
            //second ref to save it to user's own list can be used for loading personal user list
            ref2 = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("UserItemsList").child(itemNameTextField.text!)
            self.ref2?.setValue(itemData)
            let itemImageVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "itemImageVC")
            self.navigationController?.pushViewController(itemImageVC, animated: true)
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
