//
//  LoginViewController.swift
//  Detech_
//
//  Created by Teslim on 3/13/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail");
        
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword");
        
        if(userEmailStored == userEmail)
        {
            
            if (userPasswordStored == userPassword)
            {
                // Login is successfull
                
                UserDefaults.standard.set(true, forKey:"isUserLoggedin" );
                UserDefaults.standard.synchronize();
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
