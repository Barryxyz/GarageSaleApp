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

class mapViewController: UIViewController {
    let GoogleSearchPlaceApiKey = "AIzaSyCTytwuD4NgY4zE8dXXRr8N5cR_3ge28cM"
    let api = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=bar&key=" + "AIzaSyCEq3onTjJzDzmjFUzMGBpHijc8V_g5olo"
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
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
            let alertController = UIAlertController(title: "Error", message:
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
            }
            else{
                let alertController = UIAlertController(title: "Error", message:
                    "Invalid Location", preferredStyle: UIAlertController.Style.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        }
    }
    @IBAction func moveBack(_ sender: Any) {
        configureLocationServices()
        textField.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationServices()
        

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
        textField.text = place.name
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
