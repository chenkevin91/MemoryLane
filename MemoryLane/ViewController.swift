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
import PhotosUI


class ViewController: UIViewController, CLLocationManagerDelegate
{

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 5/255, green: 167/255, blue: 91/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            guard locationManager.location != nil else
            {
                centerOnLocation(location: CLLocation(latitude: 42.3601, longitude: -71.0589))
                mapView.showsUserLocation = true
                print(locationManager.location?.coordinate)
                print(mapView.userLocation.coordinate)
                return
            }
            centerOnLocation(location: locationManager.location!)
            mapView.showsUserLocation = true
            
            print(locationManager.location?.coordinate)
            print(mapView.userLocation.coordinate)
        }
        
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        
        for index in 0...(assets.count - 1)
        {
            print("assetDate: \(assets.object(at: index).creationDate)")
            guard assets.object(at: index).location != nil else
            {
                continue
            }
            populateMap(withAssetLocation: assets.object(at: index).location!)
        }
        
    }

//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) 
//    {
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
    
    func centerOnLocation(location: CLLocation)
    {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.0075, 0.0075)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func populateMap(withAssetLocation location: CLLocation)
    {
//        let testArray = [CLLocationCoordinate2D(latitude: 42.3599, longitude: -71.0587), CLLocationCoordinate2D(latitude: 42.3603, longitude: -71.0591),
//                         CLLocationCoordinate2D(latitude: 42.3607, longitude: -71.0595), CLLocationCoordinate2D(latitude: 42.3611, longitude: -71.0599)]
//        
//        for coordinate in testArray {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = coordinate
//            mapView.addAnnotation(annotation)
//        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
        
        let test = MKAnnotationView()
        
    }
}
 

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBAction func cameraButtonAction(_ sender: UIBarButtonItem)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
}

extension ViewController: MKMapViewDelegate
{
    
}

