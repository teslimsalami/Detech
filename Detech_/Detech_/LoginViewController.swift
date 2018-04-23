//
//  LoginViewController.swift
//  Detech_
//
//  Created by Teslim on 3/13/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userEmailTextField {
            
            userPasswordTextField.becomeFirstResponder()
        }else if textField == userPasswordTextField{
            textField.resignFirstResponder()
        }
        return true
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
    
    

}
