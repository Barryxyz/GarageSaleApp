//
//  ItemCell.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/30/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    
    @IBOutlet weak var cellImage: UILabel!
    @IBOutlet weak var cellSeller: UILabel!
    @IBOutlet weak var cellName: UILabel!
    @IBOutlet weak var cellPrice: UILabel!
    
    func setItemDetails(saleItem: saleItem){
        cellImage.text = saleItem.itemImage
        cellSeller.text = saleItem.itemSeller
        cellName.text = saleItem.itemName
        cellPrice.text = saleItem.itemPrice
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
