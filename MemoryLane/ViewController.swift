//
//  ViewController.swift
//  MemoryLane
//
//  Created by Kevin Chen on 10/25/16.
//  Copyright © 2016 Kevin Chen. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let regionRadius: CLLocationDistance = 4000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 42.354, longitude: -71.054)
        
        centerMapOnLocation(location: initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius,
                                                                  regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }



}

