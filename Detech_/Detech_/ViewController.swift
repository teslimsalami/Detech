//
//  ViewController.swift
//  Detech_
//
//  Created by Teslim on 3/4/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit
import CoreMotion // Import this in order to have access to accelerameter



class ViewController: UIViewController {

    var motionManager = CMMotionManager()
    
    if motionManager.deviceMotionAvailable{
                // Do something
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool)
    {
        motionManager.accelerometerUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data,error) in
            
                if let myData = data
                {
            
                    if myData.acceleration.x > 5 // looks for specific change in the data recordings for the 'x' axis, find range of epileptic seizures
                    {
                        print ("Seizure Detected!")
                    }
                    
                   //print (myData) To see update of 'x','y'and 'z'plane
                }
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// 1. Setup connection between accelerameter, and user.

// 2. Timer, data on how long seizure lasts etc...
// 3. Send emergency alert
// 4. Geolocation (google maps)
// https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/CoreLocation/CoreLocation.html
// 4. Use firebase to store data from user, includes length of user,
// 5. Create log in

//  override func motionEnded (_ motion: UIEventSubtype, with event: UIEvent?){
