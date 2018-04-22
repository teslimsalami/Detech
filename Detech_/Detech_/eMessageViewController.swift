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
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    

    

}
