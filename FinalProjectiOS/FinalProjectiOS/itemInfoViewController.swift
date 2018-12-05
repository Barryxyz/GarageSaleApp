//
//  itemInfoViewController.swift
//  FinalProjectiOS
//
//  Created by Chin, Barry Xiu Yin (bxc2gn) on 12/4/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import MessageUI

class itemInfoViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate{
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        if (result == MessageComposeResult.cancelled)
        {NSLog("Message cancelled")}
        else if (result == MessageComposeResult.sent)
        {NSLog("Message sent")}
        else
        {NSLog("Message failed")}
        controller.dismiss(animated: true)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        print(currCell.itemName)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func displayMessageInterface() {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        //Put sellers number here
        composeVC.recipients = ["17574727149"]
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
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject("Interested in " + currCell.itemName)
        //put sellers email
        picker.setToRecipients(["barryxchin@gmail.com"])
        picker.setMessageBody("", isHTML: true)
        
        present(picker, animated: true, completion: nil)
     }
     @IBAction func phoneAction(_ sender: Any) {
        //Enter sellers number here
        if let url = URL(string: "tel://15713156646") {
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
