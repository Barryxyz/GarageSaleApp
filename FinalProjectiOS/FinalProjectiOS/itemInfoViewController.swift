//
//  itemInfoViewController.swift
//  FinalProjectiOS
//
//  Created by Chin, Barry Xiu Yin (bxc2gn) on 12/4/18.
//  Copyright © 2018 Tin. All rights reserved.
//
/***************************************************************************************
 *  REFERENCES
 *  Title: SDWebImage
 *  Authors: Konstantinos K., Bogdan Poplauschi, Chester Liu, DreamPiggy, Wu Zhong
 *  Date: 12/4/2018
 *  Availability: https://github.com/SDWebImage/SDWebImage
 *  Purpose: Used SDWebImage library which is an asynchronous cache for loading images from firebase (actually directly recommended by firebase
 itself (link here: https://firebase.google.com/docs/storage/ios/download-files#downloading_images_with_firebaseui).  This was used for rounding out our cell image feature.  We had the images but had to figure out a way to manage this asynchronous process.  SDWebImage is helpful since it asynchronously loads images from firebase and caches them (leading to faster load times).  Actually recommended by firebase themselves as good solution for this asynchronous caching problem.
 *
 ***************************************************************************************/

import UIKit
import MessageUI
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SDWebImage

var sellerInfoDict: [String: String]  = ["sellerEmail" : "", "sellerPhoneNumber": ""]

class itemInfoViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate{
    
    var ref:DatabaseReference!
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        if (result == MessageComposeResult.cancelled)
        {NSLog("Message cancelled")}
        else if (result == MessageComposeResult.sent)
        {NSLog("Message sent")}
        else
        {NSLog("Message failed")}
        controller.dismiss(animated: true)
    }
    
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!    
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var streetAddress: UILabel!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var sellerContact: UILabel!
    @IBOutlet weak var sellerNameTwo: UILabel!
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        print(currCell.itemName)
        itemName.text = currCell.itemName
        itemDescription.text = currCell.itemDescription
        self.itemPrice.text = currCell.itemPrice
        self.streetAddress.text = currCell.streetAddress
        //start alert to load data
//        let loadingAlert = UIAlertController(title: nil, message: "Loading Your Profile...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 2, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = UIActivityIndicatorView.Style.gray
//        loadingIndicator.startAnimating();
//
//        loadingAlert.view.addSubview(loadingIndicator)
//        present(loadingAlert, animated: true, completion: nil)
        
        ref = Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid)
        ref.observe(.value, with: { snapshot in
            let snapshotValue = snapshot.value as! NSDictionary
            let contactMethod = snapshotValue["contactMethod"]
            let email = snapshotValue["email"] as! String
            let firstName = snapshotValue["firstName"] as! String
            let lastName = snapshotValue["lastName"] as! String
            let phoneNumber = snapshotValue["phoneNumber"] as! String
            
            //used as? so we can handle nils
            self.sellerContact.text = contactMethod as? String
            self.sellerName.text = firstName + " " +  lastName
            self.sellerNameTwo.text = firstName + " " +  lastName
            sellerInfoDict["sellerEmail"] = email
            sellerInfoDict["sellerPhoneNumber"] = phoneNumber
            //dismissing the alert after retrieving data from firebase
//            loadingAlert.dismiss(animated: false, completion: nil)
        })
        infoImageView.sd_setImage(with: URL(string: currCell.downloadURL!), placeholderImage: UIImage(named: "placeholder"))

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        //Put sellers number here has to have a 1 to start
        print("THIS IS THE SELLER NUMBER", sellerInfoDict["sellerPhoneNumber"]!)
        let finalphoneNumber: String = "1" + sellerInfoDict["sellerPhoneNumber"]!
        composeVC.recipients = [finalphoneNumber]
        composeVC.body = ""
        
        // Present the view controller modally.
        if MFMessageComposeViewController.canSendText() {
            self.present(composeVC, animated: true, completion: nil)
        } else {
            print("Can't send messages.")
        }
    }
    @IBAction func backAction(_ sender: Any) {self.navigationController?.popViewController(animated: true)
    }
     @IBAction func textAction(_ sender: Any) {
        displayMessageInterface()
     }
     @IBAction func emailAction(_ sender: Any) {
//        let picker = MFMailComposeViewController()
//        picker.mailComposeDelegate = self
//        picker.setSubject("Interested in " + currCell.itemName)
//        //put sellers email
//        picker.setToRecipients(["barryxchin@gmail.com"])
//        picker.setMessageBody("", isHTML: true)
//
//        present(picker, animated: true, completion: nil)
        if MFMailComposeViewController.canSendMail() {
            let composeMailVC = MFMailComposeViewController()
            composeMailVC.mailComposeDelegate = self
            
            composeMailVC.setToRecipients([sellerInfoDict["sellerEmail"]!])
            composeMailVC.setSubject("Interested in " + currCell.itemName)
            composeMailVC.setMessageBody("", isHTML: false)
            present(composeMailVC, animated: true, completion: nil)

        } else {
            //not all devices are configured for email
            print("THIS IS THE SELLER EMAIL", sellerInfoDict["sellerEmail"]!)

            let alertController = UIAlertController(title: "Compose Email Error", message: "Your device is not configured to send email with this app.  Please use the other two options (call or text message) to contact seller, or send an email to " + sellerInfoDict["sellerEmail"]!, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    //dismiss mail controller
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
     @IBAction func phoneAction(_ sender: Any) {
        //Enter sellers number here
        let finalphoneString: String = "1" + sellerInfoDict["sellerPhoneNumber"]!
        if let url = URL(string: "tel://" + finalphoneString) {
            print("SELLERS PHONE NUMBER MESSAGE:", sellerInfoDict["sellerPhoneNumber"]!)
            print("phone works")
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else{
            print("phone doesn't work")
        }
     }
    
     /*// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
