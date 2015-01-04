//
//  ViewController.swift
//  Swiftagram
//
//  Created by Mark on 12/30/14.
//  Copyright (c) 2014 MEB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set up Parse application
        Parse.setApplicationId("wabvjYL0hvJHpUDFGNceYAM6f7zrlS9s3qRBqn9O",
              clientKey: "JHBuhVrPu6neUZwwydgKQMqDOSIlq8eCdtzRKDtA")
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}




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

