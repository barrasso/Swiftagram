//
//  ViewController.swift
//  Swiftagram
//
//  Created by Mark on 12/30/14.
//  Copyright (c) 2014 MEB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UIImage Control
    
    // image view
    @IBOutlet weak var pickedImage: UIImageView!
    
    // chooses images
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
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        NSLog("Picked Image")
        
        // close image picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // set chosen image to UIImage
        pickedImage.image = image
    }

}





// MARK: Extra Parse Methods

/*
// set up Parse application
Parse.setApplicationId("wabvjYL0hvJHpUDFGNceYAM6f7zrlS9s3qRBqn9O",
clientKey: "JHBuhVrPu6neUZwwydgKQMqDOSIlq8eCdtzRKDtA")
*/


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

