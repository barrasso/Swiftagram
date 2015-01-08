//
//  UserTableViewController.swift
//  Swiftagram
//
//  Created by Mark on 1/7/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    // cell array
    var users = [""]
    
    // MARK: View Initialization
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var userQuery = PFUser.query()
        userQuery.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]!, error: NSError!) -> Void in
            
            
            self.users.removeAll(keepCapacity: true)
            
            for object in objects {
                
                var user:PFUser = object as PFUser
                
                self.users.append(user.username)
            }
            
            self.tableView.reloadData()
        })
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = users[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }

}
