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

    
    @IBOutlet weak var cellImage: UILabel!
    @IBOutlet weak var cellSeller: UILabel!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    
    func setItemDetails(saleItem: saleItem){
        cellImage.text = saleItem.itemCategory
        cellSeller.text = saleItem.userPosted
        cellName.text = saleItem.itemName
        cellPrice.text = saleItem.itemPrice
        
        //this is the absolute URL property not the download URL property
        let storageRef = Storage.storage().reference(forURL: "gs://finalmobileappproject-4e6a6.appspot.com/images/" +
            currItemDict["itemID"]! + ".png")
        storageRef.downloadURL(completion: { (url, error) in
            if (error != nil) {
                print("WOW BIG ERROR STOP HERE BECAUSE IMAGE HASNT BEEN LOADED")
            }
            else{
                do{
                    let data = try Data(contentsOf: url!)
                    let image = UIImage(data: data as Data)
                    //self.imageView.image = image
                    //replace line above with the cellImage stuff
                }catch{
                    print("THERE WAS AN ERROR WITH TRYING TO GET THE IMAGE IN THE TRY CATCH BLOCK")
                }
            }
        })
    }
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
