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

    
    @IBOutlet var userName: UITextField! // allows user to enter a username
    
    @IBOutlet var passWord: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let username = userName.text
        let password = passWord.text
        
        if (username == "" || password == "")
        {
            return
        }
        
        DoLogin(username!, password!)
        
    }
    
    func DoLogin(_ user:String, _ psw:String){
        
        let url = URL(string: "http://")
    }
    
    var motionManager = CMMotionManager()
    
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
                    
                   print (myData) //To see update of 'x','y'and 'z'plane
                }
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        self.performSegue(withIdentifier: "loginView", sender: self);
    }
}

// 1. Setup connection between accelerameter, and user. Figure out when the user is having a seizure.
// 2. Timer, data on how long seizure lasts etc...
// 3. Send emergency alert
// 4. Geolocation (google maps)
// https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/CoreLocation/CoreLocation.html
// 4. Use firebase to store data from user, includes length of user,
// 5. Create log in

//  override func motionEnded (_ motion: UIEventSubtype, with event: UIEvent?){
