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
    
    // pull to refresh control
    var refresher: UIRefreshControl!
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // define refresher
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "pull me")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
        
        // update all users
        updateUsers()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: User Functions
    
    func updateUsers()
    {
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
                        
                        // reload table view
                        self.tableView.reloadData()
                    }
                }
            // stop refreshing
            self.refresher.endRefreshing()
        })

    }
    
    func refresh()
    {
        updateUsers()
        NSLog("Resfreshed table.")
    }
    
    // MARK: Table View Functions
    
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
        
        // query for who the current user is following
        var query = PFQuery(className:"followers")
        query.whereKey("follower", equalTo:PFUser.currentUser().username)
        query.whereKey("following", equalTo: self.users[indexPath.row])
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // check objects count
                if objects.count > 0 {
                    // set specific cell to be checked
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            } else {
                NSLog("Error: %@", error)
            }
        }
        
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
            var query = PFQuery(className:"followers")
            query.whereKey("follower", equalTo:PFUser.currentUser().username)
            query.whereKey("following", equalTo:cell.textLabel?.text)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    for object in objects {
                        // delete all objects
                        object.deleteInBackgroundWithTarget(nil, selector: nil)
                    }
                    
                } else {
                    // Log details of the failure
                    NSLog("Error: %@", error)
                }
            }
            
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
