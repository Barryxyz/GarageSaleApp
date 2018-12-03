//
//  Artwork.swift
//  FinalProjectiOS
//
//  Created by Chin, Barry Xiu Yin (bxc2gn) on 12/1/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import MapKit
import Contacts

class ItemOnSale: NSObject, MKAnnotation {
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
    init?(json: [Any]) {
        // 1
        self.downloadURL = json[0] as? String ?? "No Title"
        self.imageAbsoluteURL = json[1] as! String
        self.itemCategory = json[2] as! String
        self.itemDescription = json[3] as! String
        self.itemName = json[4] as! String
        self.itemPrice = json[5] as! String
        // 2
        if let latitude = Double(json[7] as! String),
            let longitude = Double(json[8] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
        self.streetAddress = json[9] as! String
        self.userPosted = json[10] as! String
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
