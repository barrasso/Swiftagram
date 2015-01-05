//
//  ViewController.swift
//  Swiftagram
//
//  Created by Mark on 12/30/14.
//  Copyright (c) 2014 MEB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
    
    @IBAction func pause(sender: AnyObject)
    {
        // inital activity indicator setup
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0.0, 0.0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        // add to view and start animation
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    @IBAction func restore(sender: AnyObject)
    {
        // stop animation
        activityIndicator.stopAnimating()
        
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    @IBAction func createAlert(sender: AnyObject)
    {
        // init alert
        var alert = UIAlertController(title: "Yo", message: "whats good", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            // dismiss alert on button press
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: UIImage Control
    
    // image view outlet
    @IBOutlet weak var pickedImage: UIImageView!
    
    // chooses images action
    @IBAction func pickImage(sender: AnyObject)
    {
        // init picker controller
        var image = UIImagePickerController()
        
        // set delegate
        image.delegate = self
        
        // access photo library
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // access camera
        //image.sourceType = UIImagePickerControllerSourceType.Camera
        
        // allows user to edit picture
        image.allowsEditing = false
    
        // present the picker controller
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    // MARK: Image Picker Delegate Methods
    
    // user did finishing picking an image
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        NSLog("Picked Image")
        
        // close image picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // set chosen image to UIImage
        pickedImage.image = image
    }

}

// MARK: Extra Parse Methods

/********
//////////////////////////////////////////////////
// CREATING AND SAVING NEW PARSE CLASS + OBJECT //
//////////////////////////////////////////////////

var score = PFObject(className: "score")
score.setObject("Mark", forKey: "name")
score.setObject(95, forKey: "number")
score.saveInBackgroundWithBlock {
(success: Bool!, error: NSError!) -> Void in

if success == true
{
NSLog("Score created with ID: %@", score.objectId)
}
else
{
NSLog("Error: %@", error);
}

}
********/

/********
/////////////////////////////////////////////////////////
// QUERY, UPDATING AND SAVING NEW PARSE CLASS + OBJECT //
/////////////////////////////////////////////////////////

var query = PFQuery(className: "score")
query.getObjectInBackgroundWithId("AtKCkKXwEb") {
(score: PFObject!, error: NSError!) -> Void in

if error == nil
{
NSLog("Got Object with ID: %@", score)
score["name"] = "Markos"
score["number"] = 1236
score.saveInBackgroundWithBlock {
(success: Bool!, error: NSError!) -> Void in

if success == true
{
NSLog("Score updated with ID: %@", score.objectId)
}
else
{
NSLog("Error: %@", error);
}
}
}
else
{
NSLog("Error: %@", error);
}
}
********/

