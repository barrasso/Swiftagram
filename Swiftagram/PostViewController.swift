//
//  PostViewController.swift
//  Swiftagram
//
//  Created by Mark on 1/10/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Variables
    
    // photo selected flag
    var photoSelected:Bool = false
    
    // Activity spinner indicator
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: Outlets
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var shareTextField: UITextField!
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set text field delegate
        shareTextField.delegate = self
        
        // reset flag, caption and image
        photoSelected = false
        imageToPost.image = UIImage(named: "blank-woman-placeholder.png")
        shareTextField.text = ""
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    @IBAction func chooseImage(sender: AnyObject)
    {
        // init picker controller
        var image = UIImagePickerController()
        
        // set delegate
        image.delegate = self
        
        // access photo library
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // allows user to edit picture
        image.allowsEditing = false
        
        // present the picker controller
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func postImage(sender: AnyObject)
    {
        // define error
        var error = ""
        
        // check if user has chosen an image
        if (photoSelected == false) {
            error = "Please choose an image."
        }
        
        // check for error
        if (error != "") {
            displayAlert("Error Posting Image", error: error)
        } else {
            
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
            
            // define new parse object
            var post = PFObject(className: "Post")
            post["title"] = shareTextField.text
            post["username"] = PFUser.currentUser().username
            
            // save post with image if success
            post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                
                if success == false {
                    // stop animation and end ignoring events
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.displayAlert("Could Not Post Image", error: "Please try again later.")
                } else {
                    
                    // set image data
                    let imageData = UIImagePNGRepresentation(self.imageToPost.image)
                    
                    // save the image to PFFile
                    let imageFile = PFFile(name: "image.png", data: imageData)
                    
                    // add to post
                    post["imageFile"] = imageFile
                    
                    // save post with image if success
                    post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                        
                        // stop animation and end ignoring events
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if success == false {
                            self.displayAlert("Could Not Post Image", error: "Please try again later.")
                        } else {
                            self.displayAlert("Image Posted", error: "Your image has been posted successfully!")
                            
                            // reset flag, caption and image
                            self.photoSelected = false
                            self.imageToPost.image = UIImage(named: "blank-woman-placeholder.png")
                            self.shareTextField.text = ""
                        }
                    }
                }
            }
            
        }
    }
    
    
    // MARK: Image Picker Delegate Functions
    
    // user did finishing picking an image
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        NSLog("Picked Image")
        
        // close image picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // set chosen image to UIImage on view
        imageToPost.image = image
        
        // set photo selected flag to true
        photoSelected = true
    }
    
    // MARK: Text Field Delegate Functions
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        shareTextField.resignFirstResponder()
        return true
    }
    
    // MARK: Alert Functions
    
    func displayAlert(title:String, error:String)
    {
        // display error alert
        var errortAlert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        errortAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            // close popup and do nothing
        }))
        
        self.presentViewController(errortAlert, animated: true, completion: nil)
    }

}
