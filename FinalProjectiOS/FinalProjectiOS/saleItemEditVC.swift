//
//  saleItemEditVC.swift
//  FinalProjectiOS
//
//  Created by Tin on 12/4/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage

class saleItemEditVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var ref:DatabaseReference!
    var ref2:DatabaseReference!
    var ref3:DatabaseReference!
    var ref4:DatabaseReference!

    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var steeetAddressTextField: UITextField!
    
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
    
    @IBAction func useCamera(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: false, completion: nil)
        }
    }
        
    @IBAction func useImageLibrary(_ sender: AnyObject) {
        // Add your code here
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            itemImageView.image = image
        }
        else{
            print("Error...")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        print(currProfileItem)
        itemTextField.text = currProfileItem.itemName
        priceTextField.text = currProfileItem.itemPrice
        categoryTextField.text = currProfileItem.itemCategory
        descriptionTextField.text = currProfileItem.itemDescription
        steeetAddressTextField.text = currProfileItem.streetAddress
        //don't allow editing of item name text field (this is used in the unique id on firebase, so can't be changed), they must go to change password screen to change password
        itemTextField.isUserInteractionEnabled = false
        itemTextField.backgroundColor = UIColor.lightGray
        
        //places a border around the textview (which by default, doesn't have one)
        self.descriptionTextField.layer.borderWidth = 0.5
        self.descriptionTextField.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextField.layer.cornerRadius = 7
        let contactPicker = UIPickerView()
        categoryTextField.inputView = contactPicker
        contactPicker.delegate=self
        
        itemImageView.sd_setImage(with: URL(string: currProfileItem.downloadURL!), placeholderImage: UIImage(named: "placeholder"))
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackEditAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func onSaveEditAction(_ sender: Any) {
        //if the stuff is empty
        var isValidLocation: Bool = true
        if (steeetAddressTextField.text!.isEmpty || itemTextField.text!.isEmpty || descriptionTextField.text!.isEmpty || categoryTextField.text!.isEmpty || priceTextField.text!.isEmpty){
            let alertController = UIAlertController(title: "Post Item Error", message: "One of the fields is empty. Please enter values for all fields to post your item.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
            //        if {
            //
            //        }
            
            //this means all fields have values because if any of them didn't, it would have been caught by the if loop above
        else {
            let reverseGeoCoder = CLGeocoder()
            reverseGeoCoder.geocodeAddressString(steeetAddressTextField.text!) { (placemarks,error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                    //if else is reached here means that location was NOT FOUND MEANS THAT THE USER NEEDS TO BE STOPPED AND WE RETURN and
                    //tell user that they need to enter a valid address
                    else{
                        isValidLocation = false
                        let alertController = UIAlertController(title: "Post Item Error", message: "The address you entered is not valid.  Please enter a valid address for your item.", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                }
                //now isValidLocation will either be false or we have encountered an error processing the location
                //isValidLocation will be true if we were able to capture the location
                //post to firebase database and also show an alert which confirms item has been posted
                if (isValidLocation){
                    print(location.coordinate.latitude)
                    print(location.coordinate.longitude)
                    print(self.steeetAddressTextField.text!)
                    print(self.priceTextField.text!)
                    print(self.descriptionTextField.text!)
                    print(self.categoryTextField.text!)
                    print(self.itemTextField.text!)
                    let editValues = ["streetAddress": self.steeetAddressTextField.text!,
                                         "latitude": String(location.coordinate.latitude),
                                         "longitude": String(location.coordinate.longitude),
                                         "itemPrice": self.priceTextField.text!,
                                         "itemDescription": self.descriptionTextField.text!,
                                         "itemCategory": self.categoryTextField.text!,
                                         "itemName": self.itemTextField.text!]
                    print(currProfileItem.itemName)
                    print("THIS IS CURRENT USER ID", Auth.auth().currentUser!.uid)
                    print("GOT TO HERE")
                    self.ref = Database.database().reference().child("Items").child(currProfileItem.itemName + Auth.auth().currentUser!.uid)
                    self.ref.updateChildValues(editValues)
                    //second ref to save it to user's own list can be used for loading personal user list
                    print("THIS IS CURRENT USER ID 2", Auth.auth().currentUser!.uid)
                    print("DID NOT GET TO HERE")
                    self.ref2 = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("UserItemsList")
                        .child(currProfileItem.itemName)
                    self.ref2.updateChildValues(editValues)
                    
                    
                    let alertController = UIAlertController(title: "Edit Item Success!", message: "Your item has successfully been edited. Click back to return to your profile.", preferredStyle: .alert)
                    
                    let storageRef = Storage.storage().reference()
                    //unique ID for picture string
                    let imageTitle = NSUUID().uuidString
                    //save the currentItemID, this will update as needed
                    // Create a reference to the file you want to upload
                    let imageRefPoint = storageRef.child("images").child(imageTitle + ".png")
                    // Local file you want to upload
                    let uploadedLocalImage = self.itemImageView.image!.pngData()
                    // Upload the file to the path above
                    let uploadData = imageRefPoint.putData(uploadedLocalImage!, metadata: nil) { (metadata, error) in
                        if (error != nil){
                            print("There was an error with uploading your data")
                            return
                        }
                        //in case we want to use metadata at some point for this project?
                        guard let metadata = metadata else {
                            print("An error occured when trying to get metadata")
                            // Uh-oh, an error occurred!
                            return
                        }
                        // You can also access to download URL after upload.
                        imageRefPoint.downloadURL { (url, error) in
                            guard let downloadURL = url else {
                                print("There was an error accessing the download URL for your string")
                                return
                            }
                            let finalURL = downloadURL.absoluteString
                            //set the imageURL for the item in the list
                            let urlValue: [String:String]  = ["downloadURL": finalURL,
                                                              "imageAbsoluteURL": "gs://finalmobileappproject-4e6a6.appspot.com/images/" +
                                                                imageTitle + ".png" ]
                            print(currItemDict["itemName"]!)
                            self.ref3 = Database.database().reference().child(currProfileItem.itemName + Auth.auth().currentUser!.uid)
                            self.ref3.updateChildValues(urlValue)
                            //second ref to save it to user's own list can be used for loading personal user list
                            self.ref4 = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("UserItemsList")
                                .child(currProfileItem.itemName)
                            self.ref4.updateChildValues(urlValue)
                        }
                    }
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
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
