//
//  AddItemViewControllerImages.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/25/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import MobileCoreServices
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class AddItemViewControllerImages: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    var itemRef:DatabaseReference!
    var itemRef2:DatabaseReference!
    var itemRef3:DatabaseReference!


    //code below gets image to be shown
    @IBOutlet weak var imageProgressView: UIProgressView!
    
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    @IBAction func useCamera(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: false, completion: nil)
        }
        //        else{
        //            let imagePicker = UIImagePickerController()
        //            imagePicker.delegate = self
        //            imagePicker.allowsEditing = false
        //            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //            self.present(imagePicker, animated: false, completion: nil)
        //        }
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
            imageView.image = image
        }
        else{
            print("Error...")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        imageProgressView.layer.cornerRadius = 7
        imageProgressView.clipsToBounds = true
        imageProgressView.transform = imageProgressView.transform.scaledBy(x: 1.0, y: 4.0)
        imageProgressView.progress = 0.6666666666666666666
        itemRef = Database.database().reference()
        itemRef2 = Database.database().reference()
        //if the itemID is defined it means, we have done the next image action and loaded that image to that location
//        if (currItemDict["itemID"] != ""){
//            //start alert to load data
//            let loadingAlert = UIAlertController(title: nil, message: "Retrieving Image...", preferredStyle: .alert)
//            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
//            loadingIndicator.hidesWhenStopped = true
//            loadingIndicator.style = UIActivityIndicatorView.Style.gray
//            loadingIndicator.startAnimating();
//            loadingAlert.view.addSubview(loadingIndicator)
//            present(loadingAlert, animated: true, completion: nil)
//            let storageRef = Storage.storage().reference(forURL: "gs://finalmobileappproject-4e6a6.appspot.com/images/" +
//                currItemDict["itemID"]! + ".png")
//            storageRef.downloadURL(completion: { (url, error) in
//                if (error != nil) {
//                    print("WOW BIG ERROR STOP HERE BECAUSE IMAGE HASNT BEEN LOADED")
//                }
//                else{
//                    do{
//                       // group.enter()
//                        let data = try Data(contentsOf: url!)
//                        let image = UIImage(data: data as Data)
//                        self.imageView.image = image
//                        //group.leave()
////                        group.notify(queue:DispatchQueue.main) {
////                            self.loadingAlert!.dismiss(animated: false, completion: nil)
////                            print("everything has been completed")
////                        }
//                    }catch{
//                        print("THERE WAS AN ERROR WITH TRYING TO GET THE IMAGE IN THE TRY CATCH BLOCK")
//                    }
//                }
//            })
//            //dismiss it after everything is complete
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {loadingAlert.dismiss(animated: false, completion: nil)})
//        }
      
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapAway)))
        super.viewDidLoad()
       

    
        // Do any additional setup after loading the view.
    }
    
    func createLoadingAlert() -> UIAlertController {
        let loadingAlert = UIAlertController(title: nil, message: "Retrieving Image...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        loadingAlert.view.addSubview(loadingIndicator)
        self.present(loadingAlert, animated: true, completion: nil)
        return loadingAlert
    }
    
    //upload image into firebase storage here
    @IBAction func nextImageAction(_ sender: Any) {
        //no image loaded yet
        if (self.imageView.image == nil ){
            let alertController = UIAlertController(title: "Post Item Error", message: "You have not selected an image for your item. Please select an image to continue to the next step.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            // Points to the root reference
            let storageRef = Storage.storage().reference()
            
            //unique ID for picture string
            let imageTitle = NSUUID().uuidString
            //save the currentItemID, this will update as needed
            currItemDict["itemID"] = imageTitle
            // Create a reference to the file you want to upload
            let imageRefPoint = storageRef.child("images").child(imageTitle + ".png")
            
            // Local file you want to upload
            let uploadedLocalImage = self.imageView.image!.pngData()
            
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
                                        currItemDict["itemID"]! + ".png" ]
                    print(currItemDict["itemName"]!)
                    self.itemRef?.child("Items").child(currItemDict["itemName"]! + Auth.auth().currentUser!.uid).updateChildValues(urlValue)
                    //second ref to save it to user's own list can be used for loading personal user list
                    self.itemRef2 = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("UserItemsList")
                        .child(currItemDict["itemName"]!)
                    self.itemRef2?.updateChildValues(urlValue)
                }
            }
            //send segue to next location view controller
            let itemLocationVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "itemLocationVC")
            self.navigationController?.pushViewController(itemLocationVC, animated: true)
        }

    }

    @IBAction func backImageAction(_ sender: Any) {
        //we want it so that clicking back here keeps the image on the next runthrough assuming it hasn't changed
        //if it exists do exactly that
        //WILL ONLY EXIST WHEN USER PRESSES NEXT BECAUSE THAT MEANS THEY WANT THAT IMAGE otherwise we assume they wanted to go back first
        print("THIS IS MY CURRENT ITEM ID: " + currItemDict["itemID"]!)
        self.navigationController?.popViewController(animated: true)
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
