//
//  LoginViewController.swift
//  Swiftagram
//
//  Created by Mark on 1/5/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Text Fields
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // Buttons
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var signupToggleButton: UIButton!
    
    // Labels
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var alreadyRegistered: UILabel!
    
    @IBAction func toggleSignup(sender: AnyObject)
    {
        if (signUpActive == true)
        {
            // disable signup mode
            signUpActive = false
            
            // change text of items
            signUpLabel.text = "Log in to get started"
            alreadyRegistered.text = "Not registered yet?"
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            signupToggleButton.setTitle("Sign Up", forState: UIControlState.Normal)
        }
        else
        {
            // enable signup mode
            signUpActive = true
            
            // change text of items
            signUpLabel.text = "Sign up to get started"
            alreadyRegistered.text = "Already registered?"
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            signupToggleButton.setTitle("Log In", forState: UIControlState.Normal)
        }
    }
    
    // bool flags
    var signUpActive = true
    
    // activity spinner indicator
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Signup Functions
    
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
            self.displayAlert("Form Error", error: error)
        }
            
        else
        {
            // create a new PFUser
            var user = PFUser()
            
            // set the user's name and password
            user.username = username.text
            user.password = password.text
            
            // inital activity indicator setup
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0.0, 0.0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true;
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            // add to view and start animation
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            // begin ignoring user interaction
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            // sign up in background
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, signupError: NSError!) -> Void in
                if signupError == nil {
                    
                    // stop animation and end ignoring events
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    // now user can use app
                    
                } else {
                    
                    // stop animation and end ignoring events
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    // might be an error to display
                    if let errorString = signupError.userInfo?["error"] as? NSString {
                        error = errorString
                    } else {
                        error = "Oops. Something went wrong."
                    }
                    
                    self.displayAlert("Could Not Sign Up", error: error)
                }
            }
        }
    }
    
    // MARK: Alert Functions
    
    func displayAlert(title:String, error:String)
    {
        // display error alert
        var errortAlert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        errortAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(errortAlert, animated: true, completion: nil)
    }
}
