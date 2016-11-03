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
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 5/255, green: 167/255, blue: 91/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        if (CLLocationManager.locationServicesEnabled())
        {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestWhenInUseAuthorization()
//            locationManager.startUpdatingLocation()
            centerOnLocation(location: locationManager.location!)
            mapView.showsUserLocation = true
            
            print(locationManager.location?.coordinate)
            print(mapView.userLocation.coordinate)
        }
    }

//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
//        let location = locations.last as! CLLocation
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let span = MKCoordinateSpanMake(0.075, 0.075)
//        let region = MKCoordinateRegion(center: center, span: span)
//        mapView.setRegion(region, animated: true)
//        
//        locationManager.stopUpdatingLocation()
//    }
//    
//    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
//        print("Errors: " + error.localizedDescription)
//    }
    
    func centerOnLocation(location: CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.0075, 0.0075)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
    }
 
}
 

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBAction func cameraButtonAction(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }

}

