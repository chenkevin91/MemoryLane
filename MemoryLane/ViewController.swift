//
//  ViewController.swift
//  MemoryLane
//
//  Created by Kevin Chen on 10/25/16.
//  Copyright © 2016 Kevin Chen. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001))
//        let region = MKCoordinateRegionMakeWithDistance(center, 2000, 2000)
//        let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001))
        
        mapView.setRegion(region, animated: true)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print("Errors: " + error.localizedDescription)
    }

}

