//
//  RegisterPageViewController.swift
//  Detech_
//
//  Created by Teslim on 3/13/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTouched(_ sender: UIButton) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        
        // Check for empty fields
        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)! )
        {
            
            // Display alert message
            displayMyAlertMessage(userMessage: "All fields are required");
            return;
        }
        
        
        // Store data
        UserDefaults.standard.set(userEmail,forKey: "userEmail");
        UserDefaults.standard.set(userPassword,forKey: "userPassword");
        UserDefaults.standard.synchronize();
        
        
        // Display alert message with confirmation
        var myAlert = UIAlertController (title: "Alert", message: "Registration is successful. Thank you!", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default){
         
            action in self.dismiss(animated: true, completion: nil);
        }
        
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
        
    }
    
    
    func displayMyAlertMessage(userMessage:String)
    {
        var myAlert = UIAlertController (title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil)
        
        
    }
    
    
    
}
