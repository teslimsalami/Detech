//
//  AccelerDataViewController.swift
//  Detech_
//
//  Created by Teslim on 4/18/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit
import CoreMotion
import Foundation

class AccelerDataViewController: UIViewController {
 
    
    @IBOutlet weak var dataText: UILabel!
    
    var motionManager = CMMotionManager()
    //var emergencyContact;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //**
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
     //   view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    
    
//    func dismissKeyboard() {
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//    }
    

    
    
    override func viewDidAppear(_ animated: Bool)
    {
        motionManager.accelerometerUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data,error) in
            
            if let myData = data
            {
                
                if (myData.acceleration.x > 0.1 && myData.acceleration.y > 0.1 && myData.acceleration.z > 0.1) // looks for specific change in the data recordings for the 'x' axis, find range of epileptic seizures
//                if(emergencyContact == nil) {
//                {
                    print ("Seizure Detected!")
                    self.dataText.text = "Seizure Detected!";
                    
                    //textView.text = "Seizure Detected";
                }
               // dataLogText.text = String(myData);
             
                print (myData) //To see update of 'x','y'and 'z'plane
            }
            //}
            //else{
                //send text to emergency cntact
                
                //performSegue(withIdentifier: newSegue, sender: <#T##Any?#>)
            //}
            
            
            
        }
        
    }
    

//}
