//
//  saleItem.swift
//  FinalProjectiOS
//
//  Created by Tin on 12/1/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class saleItem: NSObject {
    let downloadURL: String?
    let imageAbsoluteURL: String
    let itemCategory: String
    let itemDescription: String
    let itemName: String
    let itemPrice: String
    let coordinate: CLLocationCoordinate2D
    let streetAddress: String
    let userPosted: String
    
    init(downloadURL: String, imageAbsoluteURL: String, itemCategory: String, itemDescription: String, itemName: String, itemPrice: String, coordinate: CLLocationCoordinate2D, streetAddress: String, userPosted: String) {
        self.downloadURL = downloadURL
        self.imageAbsoluteURL = imageAbsoluteURL
        self.itemCategory = itemCategory
        self.itemDescription = itemDescription
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.coordinate = coordinate
        self.streetAddress = streetAddress
        self.userPosted = userPosted
        super.init()
    }
    
    init?(from snapshot: DataSnapshot){
        let snapshotValue = snapshot.value as? [String: Any]
        self.downloadURL = snapshotValue?["downloadURL"] as? String ?? "https://"
        self.imageAbsoluteURL = (snapshotValue?["imageAbsoluteURL"] as? String ?? "gs://")
        self.itemCategory = (snapshotValue?["itemCategory"] as? String ?? "")
        self.itemDescription = (snapshotValue?["itemDescription"] as? String ?? "")
        self.itemName = (snapshotValue?["itemName"] as? String ?? "")
        self.itemPrice = (snapshotValue?["itemPrice"] as? String ?? "")
        if let latitude = Double(snapshotValue!["latitude"] as? String ?? "0.0"),
            let longitude = Double(snapshotValue!["longitude"] as? String ?? "0.0") {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
        self.streetAddress = (snapshotValue?["streetAddress"] as? String ?? "")
        self.userPosted = (snapshotValue?["userPosted"] as? String ?? "")
    }
}
