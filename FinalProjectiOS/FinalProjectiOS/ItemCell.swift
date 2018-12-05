//
//  ItemCell.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/30/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import MobileCoreServices
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class ItemCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    
//  I moved this code to the itemlistviewcontroller swift file
//    func setItemDetails(saleItem: saleItem){
//        cellSeller.text = saleItem.userPosted
//        cellName.text = saleItem.itemName
//        cellPrice.text = saleItem.itemPrice
//
//        //this is the absolute URL property not the download URL property gets the image
//        let storageRef = Storage.storage().reference(forURL: "gs://finalmobileappproject-4e6a6.appspot.com/images/961E05F2-F1AE-48BF-9E70-13A1C4DBB827.png")
//        storageRef.downloadURL(completion: { (url, error) in
//            if (error != nil) {
//                print("WOW BIG ERROR STOP HERE BECAUSE IMAGE HASNT BEEN LOADED")
//            }
//            else{
//                do{
//                    let data = try Data(contentsOf: url!)
//                    let image = UIImage(data: data as Data)
//                    self.cellImage.image = image
//                    //self.imageView.image = image
//                    //replace line above with the cellImage stuff
//                }catch{
//                    print("THERE WAS AN ERROR WITH TRYING TO GET THE IMAGE IN THE TRY CATCH BLOCK")
//                }
//            }
//        })
//    }
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
