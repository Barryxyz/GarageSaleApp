//
//  itemInfoViewController.swift
//  FinalProjectiOS
//
//  Created by Chin, Barry Xiu Yin (bxc2gn) on 12/4/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import MessageUI

class itemInfoViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
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
        composeVC.recipients = ["17574727149"]
        composeVC.body = "I love Swift!"
        
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
     }
     @IBAction func phoneAction(_ sender: Any) {
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
