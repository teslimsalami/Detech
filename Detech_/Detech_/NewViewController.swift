//
//  NewViewController.swift
//  Detech_
//
//  Created by Teslim on 4/17/18.
//  Copyright © 2018 Teslim Salami. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        
        
        UserDefaults.standard.set(false, forKey:"isUserLoggedin" );
        UserDefaults.standard.synchronize();
        
        self.performSegue(withIdentifier: "loginView", sender: self);
        
        
    }
    
    
    
    
    
}
