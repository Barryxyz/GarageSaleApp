//
//  mapViewController.swift
//  FinalProjectiOS
//
//  Created by Chin, Barry Xiu Yin (bxc2gn) on 11/16/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces
import FirebaseAuth
import FirebaseDatabase

class mapViewController: UIViewController {
    var ref:DatabaseReference!
    var itemsOnSale: [ItemOnSale] = []
    let GoogleSearchPlaceApiKey = "AIzaSyCTytwuD4NgY4zE8dXXRr8N5cR_3ge28cM"
    let api = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=bar&key=" + "AIzaSyCEq3onTjJzDzmjFUzMGBpHijc8V_g5olo"
    var current = CLLocationCoordinate2D()
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    private var selectedName = "No title was found"
    private var selectedAddress = "No address was found"
    private var selectedCoordinate: CLLocationCoordinate2D?
    var selectedPlace = locationPicker(title: "Cheese",

                                locationName: "Cheese",
                                discipline: "Sculpture",
                               coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func textFieldTapped(_ sender: Any) {
        textField.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self as GMSAutocompleteViewControllerDelegate
        present(acController, animated: true, completion: nil)

    }
    @IBAction func moveCoordinate(_ sender: Any) {
        let address = textField.text!
        if(address == ""){
            let alertController = UIAlertController(title: "Location Error", message:
                "No address was selected", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            let location = placemarks?.first?.location?.coordinate
            print("Lat: \(String(describing: lat)), Lon: \(String(describing: lon))")
            if(location != nil){ self.zoomToLatestLocation(with: location!)
                self.mapView.removeAnnotation(self.selectedPlace);
                self.selectedCoordinate = location
                self.selectedPlace = locationPicker(title: String(self.selectedName),
                                            locationName: String(self.selectedAddress),
                                      discipline: "Sculpture",
                                     coordinate: self.selectedCoordinate!)
                self.mapView.addAnnotation(self.selectedPlace)
            }
            else{
                let alertController = UIAlertController(title: "Location Error", message:
                    "Invalid Location", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        }
    }
    @IBAction func moveBack(_ sender: Any) {
        zoomToLatestLocation(with: current)
        textField.text = ""
    }
//    func loadInitialData() {
//        // 1
//        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
//            else { return }
//        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: "https://finalmobileappproject-4e6a6.firebaseio.com/Items.json?"))
//
//        guard
//            let data = optionalData,
//            // 2
//            let json = try? JSONSerialization.jsonObject(with: data),
//            // 3
//            let dictionary = json as? [String: Any],
//            // 4
//            let works = dictionary["data"] as? [[Any]]
//            else { return }
//        // 5
//        let validWorks = works.flatMap { Artwork(json: $0)}
//        artworks.append(contentsOf: validWorks)
//    }
    
    func loadInitialData(){
        var itemList: [ItemOnSale] = []
        ref = Database.database().reference(withPath: "Items")
        ref.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let item = ItemOnSale(from: snapshot) {
                    self.mapView.addAnnotation(item)
                    itemList.append(item)
                    print(itemList)
                }
                
//                let snapshotValue = snapshot.value as! NSDictionary
//                print(child)
//                let downloadURL = snapshotValue["downloadUrl"]
//                let imageAbsoluteURL = snapshotValue["imageAbsoluteUrl"]
//                let itemCategory = snapshotValue["itemCategory"]
//                let itemDescription = snapshotValue["itemDescription"]
//                let itemName = snapshotValue["itemName"]
//                let itemPrice = snapshotValue["itemPrice"]
//                print(itemPrice)
//                var coordinate = CLLocationCoordinate2D()
//                if let latitude = Double(snapshotValue["latitude"] as! String),
//                    let longitude = Double(snapshotValue["longitude"] as! String) {
//                    coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//                } else {
//                    coordinate = CLLocationCoordinate2D()
//                }
//                let streetAddress = snapshotValue["streetAddress"]
//                let userPosted = snapshotValue["userPosted"]
//
//                let item = ItemOnSale(downloadURL: downloadURL as! String, imageAbsoluteURL: imageAbsoluteURL as! String, itemCategory: itemCategory as! String, itemDescription: itemDescription as! String, itemName: itemName as! String, itemPrice: itemPrice as! String, coordinate: coordinate, streetAddress: streetAddress as! String, userPosted: userPosted as! String)
//                addItems.append(item)
            }

    })
        self.itemsOnSale = itemList
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        mapView.delegate = self
        mapView.register(ArtworkMarkerView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadInitialData()
        mapView.addAnnotations(itemsOnSale)
//        loadInitialData()
//        let artwork = Artwork(title: "King David Kalakaua",
//                              locationName: "Waikiki Gateway Park",
//                              discipline: "Sculpture",
//                              coordinate: CLLocationCoordinate2D(latitude: 38.0506172, longitude: -78.5039878))
//        mapView.addAnnotation(artwork)
        

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    private func configureLocationServices(){
        locationManager.delegate = self
        
        let status = CLLocationManager.authorizationStatus()
        
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestAlwaysAuthorization()
        }
        else if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates(LocationManager: locationManager)
        }
    }
    private func beginLocationUpdates(LocationManager: CLLocationManager){
        mapView.showsUserLocation = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D){
        let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(zoomRegion, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
extension mapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did get latest location")
        guard let latestLocation = locations.first else { return }
        
        if currentCoordinate == nil {
            zoomToLatestLocation(with: latestLocation.coordinate)
        }
        
        currentCoordinate = latestLocation.coordinate
        current = latestLocation.coordinate
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("The status changed")
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            beginLocationUpdates(LocationManager: manager)
        }
    }
}
extension mapViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        textField.text = place.formattedAddress
        selectedAddress = place.formattedAddress!
        selectedName = place.name
        // Dismiss the GMSAutocompleteViewController when something is selected
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}

extension mapViewController: MKMapViewDelegate{
    // 1
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // 2
//        guard let annotation = annotation as? ItemOnSale else { return nil }
//        // 3
//        let identifier = "marker"
//        var view: MKMarkerAnnotationView
//        // 4
//        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//            as? MKMarkerAnnotationView {
//            dequeuedView.annotation = annotation
//            view = dequeuedView
//        } else {
//            // 5
//            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//            view.canShowCallout = true
//            view.calloutOffset = CGPoint(x: -5, y: 5)
//            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//        }
//        return view
//    }
}
