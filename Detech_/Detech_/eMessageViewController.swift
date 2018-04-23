//
//  eMessageViewController.swift
//  Detech_
//
//  Created by Teslim on 4/21/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit
import MessageUI

class eMessageViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    

        // Needs a button in order to make "Expected declaration" button go away
   
    @IBAction func userSendsText(_ sender: UIButton)
    {
        
        
        do {
        let controller = MFMessageComposeViewController()
        controller.body = "Your loved one is having a seizure!"
        controller.recipients = ["7739803235"] // We will enter the users emergency contact's number from the EmegencycontactViewController
        controller.messageComposeDelegate = self; // I think this determines if we want the user to physically send the message or for it to be automatic
        self.present(controller, animated: true, completion: nil)
        }
    
        }
    
    
    
    }



