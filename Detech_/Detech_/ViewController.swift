//
//  ViewController.swift
//  Detech_
//
//  Created by Teslim on 3/4/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import CoreMotion // Import this in order to have access to accelerameter
import Foundation
//import GoogleMaps



class ViewController: UIViewController {
    
// MARK Geolocation
 
    @IBAction func userLocationTouched(_ sender: UIButton) {
        
        class ViewController: UIViewController, CLLocationManagerDelegate {
            
            // Used to start getting the users location
            let locationManager = CLLocationManager()
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                
                // For use when the app is open & in the background
                locationManager.requestAlwaysAuthorization()
                
                // For use when the app is open
                //locationManager.requestWhenInUseAuthorization()
                
                // If location services is enabled get the users location
                if CLLocationManager.locationServicesEnabled() {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
                    locationManager.startUpdatingLocation()
                }
            }
            
            // Print out the location to the console
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                if let location = locations.first {
                    print(location.coordinate)
                }
            }
            
            // If we have been deined access give the user the option to change it
            func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
                if(status == CLAuthorizationStatus.denied) {
                    showLocationDisabledPopUp()
                }
            }
            
            // Show the popup to the user if we have been deined access
            func showLocationDisabledPopUp() {
                let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                        message: "In order to deliver pizza we need your location",
                                                        preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
                    if let url = URL(string: UIApplicationOpenSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                alertController.addAction(openAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    



    
    
//    // Allows user to enter text into field
//    @IBOutlet weak var myTextField: UITextField!
//
//
//    var ref:DatabaseReference?
//
//    // Will create a database for a user
//    @IBAction func saveButton(_ sender: UIButton) {     // Allows user to save the users info to Firebase
//
//        ref = Database.database().reference()
//
//        if myTextField.text != ""
//
//        {
//            ref?.child("list").childByAutoId().setValue(myTextField.text)
//
//        }
//
//    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
// MARK User loggin
    override func viewDidDisappear(_ animated: Bool)
    {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggIn");
        
        if(!isUserLoggedIn)
        {
            self.performSegue(withIdentifier: "loginView", sender: self); // Will present user with login view
            
        }
        
    }
    

    
    
// END User loggin
    
 
}

// 1. Setup connection between accelerameter, and user. Figure out when the user is having a seizure. (Everyone)

// https://developer.apple.com/documentation/accelerate/vdsp?language=objc

// https://developer.apple.com/documentation/accelerate/1449755-fftwindow?language=objc

// 2. Data on how long seizure lasts etc... (Everyone)

// 3. Send emergency alert

// 4. Geolocation (google maps)
// https://youtu.be/UyiuX8jULF4 - Exact video (Giovanni)


// 5. Use firebase to store data from user, includes length of user,
// https://www.youtube.com/watch?v=1deyxn5jVXk - Exact Video (Teslim)

// 6. Create log in - (Teslim)

