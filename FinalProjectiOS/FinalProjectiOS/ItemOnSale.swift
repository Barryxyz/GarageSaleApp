//
//  Artwork.swift
//  FinalProjectiOS
//
//  Created by Chin, Barry Xiu Yin (bxc2gn) on 12/1/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import MapKit
import Contacts
import FirebaseAuth
import FirebaseDatabase

class ItemOnSale: NSObject, MKAnnotation {
    let title: String?
    let downloadURL: String?
    let imageAbsoluteURL: String
    let itemCategory: String
    let itemDescription: String
    let itemName: String
    let itemPrice: String
    let coordinate: CLLocationCoordinate2D
    let streetAddress: String
    let userPosted: String
    
    var markerTintColor: UIColor  {
        switch itemCategory {
        case "Furniture":
            return .red
        case "School":
            return .cyan
        case "Clothes":
            return .blue
        case "Other":
            return .purple
        default:
            return .green
        }
    }
    
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
        self.title = "Cheese"
        super.init()
    }
    init?(from snapshot: DataSnapshot){
        let snapshotValue = snapshot.value as? [String: Any]
        self.downloadURL = snapshotValue?["downloadURL"] as? String
        self.imageAbsoluteURL = (snapshotValue?["imageAbsoluteURL"] as? String)!
        self.itemCategory = (snapshotValue?["itemCategory"] as? String)!
        self.itemDescription = (snapshotValue?["itemDescription"] as? String)!
        self.itemName = (snapshotValue?["itemName"] as? String)!
        self.itemPrice = (snapshotValue?["itemPrice"] as? String)!
        if let latitude = Double(snapshotValue!["latitude"] as! String),
            let longitude = Double(snapshotValue!["longitude"] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
        self.streetAddress = (snapshotValue?["streetAddress"] as? String)!
        self.userPosted = (snapshotValue?["userPosted"] as? String)!
        self.title = "Cheese"
    }
    var subtitle: String? {
        return streetAddress
    }
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = itemName
        return mapItem
    }
}
