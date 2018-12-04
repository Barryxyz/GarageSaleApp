//
//  saleItem.swift
//  FinalProjectiOS
//
//  Created by Tin on 12/1/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import Foundation
import UIKit

class saleItem{
    var itemImage: String //change this back to UIImageView after finishing testing
    var itemName: String
    var itemSeller: String
    var itemPrice: String
    
    init(itemImage: String, itemName: String, itemSeller: String, itemPrice: String) {
        self.itemImage = itemImage
        self.itemName = itemName
        self.itemSeller = itemSeller
        self.itemPrice = itemPrice
    }
    
}
