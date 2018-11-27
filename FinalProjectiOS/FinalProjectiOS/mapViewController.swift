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
    let GoogleSearchPlaceApiKey = "AIzaSyCEq3onTjJzDzmjFUzMGBpHijc8V_g5olo"
    let api = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=bar&key=" + "AIzaSyCEq3onTjJzDzmjFUzMGBpHijc8V_g5olo"
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocationCoordinate2D?
    @IBOutlet weak var mapView: MKMapView!
    
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
