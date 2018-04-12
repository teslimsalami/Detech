//
//  ViewController.swift
//  Detech_
//
//  Created by Teslim on 3/4/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI
import FirebaseDatabase
import CoreMotion // Import this in order to have access to accelerameter
import Foundation
//import GoogleMaps



class ViewController: UIViewController {
    
    
// MARK FFTCalculator.m
    
    
    
    
    
    
    
    
    
    
    
    
// END FFTCalculator.m
    
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
    
//    class ViewController: UIViewController, CLLocationManagerDelegate {
//
//        // Used to start getting the users location
//        let locationManager = CLLocationManager()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//
//
//            // For use when the app is open & in the background
//            locationManager.requestAlwaysAuthorization()
//
//            // For use when the app is open
//            //locationManager.requestWhenInUseAuthorization()
//
//            // If location services is enabled get the users location
//            if CLLocationManager.locationServicesEnabled() {
//                locationManager.delegate = self
//                locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
//                locationManager.startUpdatingLocation()
//            }
//        }
//
//        // Print out the location to the console
//        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            if let location = locations.first {
//                print(location.coordinate)
//            }
//        }
//
//        // If we have been deined access give the user the option to change it
//        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//            if(status == CLAuthorizationStatus.denied) {
//                showLocationDisabledPopUp()
//            }
//        }
//
//        // Show the popup to the user if we have been deined access
//        func showLocationDisabledPopUp() {
//            let alertController = UIAlertController(title: "Background Location Access Disabled",
//                                                    message: "In order to deliver pizza we need your location",
//                                                    preferredStyle: .alert)
//
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alertController.addAction(cancelAction)
//
//            let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
//                if let url = URL(string: UIApplicationOpenSettingsURLString) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }
//            }
//            alertController.addAction(openAction)
//
//            self.present(alertController, animated: true, completion: nil)
//        }
//
//    }
    
    
    
    
    
    
    
    
    
    
    
    
//    override func loadView() {
//         // Create a GMSCameraPosition that tells the map to display the
//         // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
//
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
    
    
    
// END Geolocation


    
    
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
// ******Watch youtube video
// MARK Accelerometer
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        //** Call Objective C files to swift
        
        
//        var FFT:FFTCalculator  = FFTCalculator();
//        FFT.accessibilityDecrement();
//
        
        //**
        

        
        
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        motionManager.accelerometerUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data,error) in
            
                if let myData = data
                {
            
                    if (myData.acceleration.x > 0.1 && myData.acceleration.y > 0.1 && myData.acceleration.z > 0.1) // looks for specific change in the data recordings for the 'x' axis, find range of epileptic seizures
                    {
                        print ("Seizure Detected!")
                    }
                    
                   print (myData) //To see update of 'x','y'and 'z'plane
                }
        }
        
    }
    
    
    
    
    
// END Accelerometer
    
    
    
    
    
    
    
    
    
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
    
    @IBAction func createEmergencyContact(_ sender: UIButton) {
        
    
        
        class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {
            
            @IBOutlet weak var phoneNumber: UITextField!
            
            override func viewDidLoad() {
                super.viewDidLoad()
            }
            
            @IBAction func sendText(sender: UIButton) {
                if (MFMessageComposeViewController.canSendText()) {
                    let controller = MFMessageComposeViewController()
                    controller.body = "Message Body"
                    controller.recipients = [phoneNumber.text!]
                    controller.messageComposeDelegate = self
                    self.present(controller, animated: true, completion: nil)
                }
            }
            
            func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
                //... handle sms screen actions
                self.dismiss(animated: true, completion: nil)
            }
            
            override func viewWillDisappear(_ animated: Bool) {
                self.navigationController?.isNavigationBarHidden = false
            }
        }
        
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey:"isUserLoggedin" );
        UserDefaults.standard.synchronize();
        
        self.performSegue(withIdentifier: "loginView", sender: self);
        
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

