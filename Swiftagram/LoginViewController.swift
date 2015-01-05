//
//  LoginViewController.swift
//  Swiftagram
//
//  Created by Mark on 1/5/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func signUp(sender: AnyObject)
    {
        // init error string
        var error = "";
        
        // check for empty username or password text fields
        if (username.text == "" || password.text == "")
        {
            error = "Please enter a username and password"
        }
        // check for minimum / maximum username string length
        else if (countElements(username.text) >= 11 || countElements(username.text) <= 2)
        {
            error = "Invalid username length. Must be 3 - 10 characters"
        }
        
        // check for minimum / maximum password string length
        else if (countElements(password.text) >= 21 || countElements(password.text) <= 6)
        {
            error = "Invalid password length. Must be 7 - 20 characters"
        }
        
        // if the error string is not empty
        if (error != "")
        {
            // display error alert
            var errortAlert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.Alert)
            errortAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(errortAlert, animated: true, completion: nil)
        }
    }
}
