//
//  PostViewController.swift
//  Swiftagram
//
//  Created by Mark on 1/10/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Outlets
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var shareTextField: UITextField!
    
    // MARK: Actions
    @IBAction func chooseImage(sender: AnyObject)
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
    
    @IBAction func postImage(sender: AnyObject)
    {
        
    }
    
    
    // MARK: Image Picker Delegate Methods
    
    // user did finishing picking an image
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        NSLog("Picked Image")
        
        // close image picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // set chosen image to UIImage
        imageToPost.image = image
    }
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    

}
