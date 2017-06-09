//
//  ViewController.swift
//  MapApp
//
//  Created by David Winnicki on 2017-06-09.
//  Copyright © 2017 Winnicki. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    // MARK: - Oulets and actions
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func btnDropPinTouched(_ sender: UIBarButtonItem) {
        let pin = Pin(coordinate: mapView.userLocation.coordinate)
        mapView.addAnnotation(pin)
    }
    
    // MARK: - Instance variables
    
    var currentLocation: CLLocationCoordinate2D?
    var locationManager: CLLocationManager?
    
    func configureLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            configureLocationManager()
            mapView.setUserTrackingMode(.follow, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location?.coordinate
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let width = 100.0
        let height = 100.0
        let region = MKCoordinateRegionMakeWithDistance(center, width, height)
        mapView.setRegion(region, animated: true)
    }
}
