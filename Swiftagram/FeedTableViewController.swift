//
//  FeedTableViewController.swift
//  Swiftagram
//
//  Created by Mark on 1/19/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    
    // feed arrays
    var captions = [String]()
    var usernames = [String]()
    var images = [UIImage]()
    var imageFiles = [PFFile]()

    // MARK: - View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // download all users that current user is following
        var getFollowedUsersQuery = PFQuery(className: "followers")
        getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser().username)
        getFollowedUsersQuery.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                // init followed user
                var followedUser = ""
                
                for object in objects {
                    
                    // get followed user
                    followedUser = object["following"] as String
                    
                    // query for all posted objects from followed users
                    var query = PFQuery(className: "Post")
                    query.whereKey("username", equalTo: followedUser)
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [AnyObject]!, error: NSError!) -> Void in
                        if error == nil {
                            
                            println("successfully retrieved objects: \(objects.count)")
                            
                            for object in objects {
                                
                                // get captions and usernames and add to arrays
                                self.captions.append(object["title"] as String)
                                self.usernames.append(object["username"] as String)
                                self.imageFiles.append(object["imageFile"] as PFFile)
                                
                                // get photo post time
                                
                                // reload table data
                                self.tableView.reloadData()
                            }
                        } else {
                            println("Error: \(error)")
                        }
                    }
                }
                
            } else {
                println("Error: \(error)")
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - TableView Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // Return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Return the number of rows in the section.
        return captions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // init cell
        var myCell:Cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as Cell

        // set username and caption labels
        myCell.titleLabel.text = captions[indexPath.row]
        myCell.captionLabel.text = usernames[indexPath.row]
        
        // query for image data
        imageFiles[indexPath.row].getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                
                // create image from data
                let image = UIImage(data: imageData)
                myCell.postedImage.image = image
                
            } else {
                println("Error: \(error)")
            }
        }

        return myCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
