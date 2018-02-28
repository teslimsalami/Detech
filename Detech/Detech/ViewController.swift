//
//  ViewController.swift
//  Detech
//
//  Created by Teslim on 2/16/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit
import MessageUI



class ViewController: UIViewController,MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //@IBAction func sendText(sender: UIButton) {              // Updated message response to emergency contacts
        
        
//        if (MFMessageComposeViewController.canSendText()) {
//            let controller = MFMessageComposeViewController()
//            controller.body = "Seizure. Send help!"
//            controller.recipients = [phoneNumber.text!]
//            controller.messageComposeDelegate = self
//            self.present(controller, animated: true, completion: nil)
//        }
        
    }
    @IBAction func emergencyTextPressed(_ sender: UIButton) {
        
        // This will send text to emergency contacts
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Seizure. Send help!"
            controller.recipients = [phoneNumber.text!]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionEnded (_ motion: UIEventSubtype, with event: UIEvent?){
        
        // Alert emergency contacts and store database
        // Create stats on duration of seizure, where and when it happened
        
        
        }
}





// 1. Setup connection between acceleramotor, and user. COMPLETE?


// func accelerometerData(from fromDate: Date, to toDate: Date) -> CMSensorDataList?



// 2. Timer, data on how long seizure lasts etc...
// 3. Send emergency alert
// 4. Geolocation (google maps)

//https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/CoreLocation/CoreLocation.html

// 4. Use firebase to store data from user, includes length of user,
// 5. Create log in

//  override func motionEnded (_ motion: UIEventSubtype, with event: UIEvent?){





// newBallImage()
//}
