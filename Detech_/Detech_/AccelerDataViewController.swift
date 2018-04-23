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
    
    @IBOutlet weak var emergencyContactInfo_: UITableView!
    
    
    
    var motionManager = CMMotionManager()
    var emergencyContact = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emergencyContactInfo_ = emergencyContact
        //**

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        motionManager.accelerometerUpdateInterval = 0.2
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data,error) in
            
            if let myData = data
            {
                
                if (myData.acceleration.x > 0 && myData.acceleration.y > 0 && myData.acceleration.z > 0) {// looks for specific change in the data recordings for the 'x,y,z' axis, find range of epileptic seizures
                    //if(emergencyContact == nil) {
                    do {
                    print ("Seizure Detected!")
                    self.dataText.text = "Seizure Detected!";

                    //textView.text = "Seizure Detected";
                }
               // dataLogText.text = String(myData);
             
                print (myData) //To see update of 'x','y'and 'z'plane
            }
              }
            //else{
                //send text to emergency cntact
                
                //performSegue(withIdentifier: "sendText", sender: self)
            }
            
            
            
        }
        
    }
    

