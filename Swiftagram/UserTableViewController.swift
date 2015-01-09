//
//  UserTableViewController.swift
//  Swiftagram
//
//  Created by Mark on 1/7/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    // users cell array
    var users = [""]
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // query for users
        var userQuery = PFUser.query()
        userQuery.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error: NSError!) -> Void in
            
            // clean up users array
            self.users.removeAll(keepCapacity: true)
            
            // for all found objects
            for object in objects
            {
                // get the user
                var user:PFUser = object as PFUser
                
                // check for current user's username
                if object.username != PFUser.currentUser().username
                {
                    // add to users array
                    self.users.append(user.username)
                }
            }
            
            // reload table view
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // get cell
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        // set cell text label
        cell.textLabel?.text = users[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        // get selected cell
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        // if cell is checked
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            // uncheck cell
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            // must remove following/follower names for respective object
            
        }
        else {
            // check cell
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            // create parse object
            var following = PFObject(className: "followers")
            
            // set following/follower names for respective object
            following["following"] = cell.textLabel?.text
            following["follower"] = PFUser.currentUser().username
            
            // save object
            following.saveInBackgroundWithTarget(nil, selector: nil)
        }
        
    }

}
