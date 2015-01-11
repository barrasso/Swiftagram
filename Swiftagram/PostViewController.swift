//
//  PostViewController.swift
//  Swiftagram
//
//  Created by Mark on 1/10/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Variables
    
    var photoSelected:Bool = false
    
    // MARK: Outlets
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var shareTextField: UITextField!
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
            error = "Please select an image to post"
        }
        
        // check for error string
        if (error != "") {
            displayAlert("Error posting image", error: error)
        }
    }
    
    
    // MARK: Image Picker Delegate Methods
    
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
