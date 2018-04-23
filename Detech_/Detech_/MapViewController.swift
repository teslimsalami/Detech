//
//  MapViewController.swift
//  Detech_
//
//  Created by Teslim on 4/17/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    //@IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    let annotations = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Do any additional setup after loading the view.
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        map.setRegion(region, animated: true)
        
        map.showsUserLocation = true
    }

}
