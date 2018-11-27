//
//  AddItemViewControllerLocation.swift
//  FinalProjectiOS
//
//  Created by Tin on 11/25/18.
//  Copyright © 2018 Tin. All rights reserved.
//

import UIKit
import CoreLocation

class AddItemViewControllerLocation: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var locationManager: CLLocationManager?
    var userLocGeocoder: CLGeocoder?
    
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var locationProgressView: UIProgressView!
    
    
    func createLocationManager(startImmediately: Bool){
        //this is the code that allows us to start our location manager and starts to find the location
        locationManager = CLLocationManager()
        locationManager!.delegate = self;
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager!.requestWhenInUseAuthorization();
        locationManager!.startUpdatingLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //get text fields and update them with current latitude and longitude
        let userCurrLocation:CLLocationCoordinate2D = (manager.location?.coordinate)!
        userLocGeocoder = CLGeocoder()
        let location = CLLocation(latitude: userCurrLocation.latitude, longitude: userCurrLocation.longitude)
        userLocGeocoder!.reverseGeocodeLocation(location, completionHandler: {(placemark, error) in
            //if there is an error
            if (error != nil) {
                print("Error in reverseGeocode")
                let alertController = UIAlertController(title: "Geocode Location Error", message: "There is an error with translating your current location. Please try again.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
                //get the placemark
            else{
                let user_placemark = placemark! as [CLPlacemark]
                if user_placemark.count > 0 {
                    let user_placemark = placemark![0]
                    self.streetAddressTextField.text = user_placemark.subThoroughfare! + " " + user_placemark.thoroughfare!
                    self.zipCodeTextField.text = user_placemark.postalCode!
                    self.cityTextField.text = user_placemark.locality!
                    self.stateTextField.text = user_placemark.administrativeArea!
                }
            }
            
        })
        //reverse Geocode from latitude and longitude to get the address inf
    }
    
    @IBAction func currLocationButton(_ sender: Any) {
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled(){
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus(){
            case .authorizedAlways:
                /* Yes, always */
                createLocationManager(startImmediately: true)
            case .authorizedWhenInUse:
                /* Yes, only when our app is in use  */
                createLocationManager(startImmediately: true)
            case .denied:
                /* No */
                displayAlertWithTitle(title: "Not Determined",
                                      message: "Location services are not allowed for this app")
            case .notDetermined:
                /* We don't know yet, we have to ask */
                createLocationManager(startImmediately: false)
                if let manager = self.locationManager{
                    manager.requestWhenInUseAuthorization()
                }
            case .restricted:
                /* Restrictions have been applied, we have no access
                 to location services */
                displayAlertWithTitle(title: "Restricted",
                                      message: "Location services are not allowed for this app")
            }
        } else {
            /* Location services are not enabled.
             Take appropriate action: for instance, prompt the
             user to enable the location services */
            let alertController = UIAlertController(title: "Location Services Error", message: "Please enable location services for the GarageSale app in your user settings.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            print("Location services are not enabled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        // Code here is called on an error - no edits needed.
        print("Location manager failed with error = \(error)")
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // Code here is called when authoization changes - no edits needed.
        print("The authorization status of location services is changed to: ", terminator: "")
        
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            print("Authorized")
        case .authorizedWhenInUse:
            print("Authorized when in use")
        case .denied:
            print("Denied")
        case .notDetermined:
            print("Not determined")
        case .restricted:
            print("Restricted")
        }
        
    }
    
    func displayAlertWithTitle(title: String, message: String){
        // Helper function for displaying dialog windows - no edits needed.
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
        
        present(controller, animated: true, completion: nil)
        
    }
    
    //manages the pickerView for choosing state text field
    
    let contactPickerData = [String](arrayLiteral:"AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY")
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contactPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contactPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stateTextField.text = contactPickerData[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contactPicker = UIPickerView()
        stateTextField.inputView = contactPicker
        contactPicker.delegate=self
        locationProgressView.layer.cornerRadius = 7
        locationProgressView.clipsToBounds = true
        locationProgressView.transform = locationProgressView.transform.scaledBy(x: 1.0, y: 4.0)
        locationProgressView.progress = 1.0

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backLocationAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func postItemAction(_ sender: Any) {
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
