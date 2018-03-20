//
//  ViewController.swift
//  Detech_
//
//  Created by Teslim on 3/4/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreMotion // Import this in order to have access to accelerameter



class ViewController: UIViewController {
    
    // Allows user to enter text into field
    @IBOutlet weak var myTextField: UITextField!
    
    
    var ref:DatabaseReference?
    
    // Will create a database for a user
    @IBAction func saveButton(_ sender: UIButton) {     // Allows user to save the users info to Firebase
        
        ref = Database.database().reference()
        
        if myTextField.text != ""
        
        {
            ref?.child("list").childByAutoId().setValue(myTextField.text)
        
        }
    
    }
        
    
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggIn");
        
        if(!isUserLoggedIn)
        {
            self.performSegue(withIdentifier: "loginView", sender: self); // Will present user with login view
            
        }
        
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        UserDefaults.standard.set(false, forKey:"isUserLoggedin" );
        UserDefaults.standard.synchronize();
        
        self.performSegue(withIdentifier: "loginView", sender: self);
        
    }
    
    
    
    
}

// 1. Setup connection between accelerameter, and user. Figure out when the user is having a seizure. (Everyone)

// https://developer.apple.com/documentation/accelerate/vdsp?language=objc

// https://developer.apple.com/documentation/accelerate/1449755-fftwindow?language=objc

// 2. Timer, data on how long seizure lasts etc... (Everyone)

// 3. Send emergency alert

// 4. Geolocation (google maps)
// https://youtu.be/UyiuX8jULF4 - Exact video (Giovanni)

// 5. Use firebase to store data from user, includes length of user,
// https://www.youtube.com/watch?v=1deyxn5jVXk - Exact Video (Teslim)

// 6. Create log in - (Teslim)

//  override func motionEnded (_ motion: UIEventSubtype, with event: UIEvent?){
