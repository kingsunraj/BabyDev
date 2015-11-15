//
//  TasksViewController.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var tasks = [Task(name: "Match sounds to words", min: 3, max: 8, interactive: false), Task(name: "Repeat sounds", min: 2, max: 5, interactive: true), Task(name: "Lay on back", min: 1, max: 3, interactive: false), Task(name: "Lay on stomach", min: 2, max: 4, interactive: false), Task(name: "Trace drawing", min: 12, max: 25, interactive: false), Task(name: "Pick colors", min: 6, max: 12, interactive: false), Task(name: "Identify Parents", min: 4, max: 5, interactive: true)]
    
    var titleLabel = UILabel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "barButtonItemClicked:"), animated: true) // add bbutton on bar
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
        // init the label for nav bar title
        
        // titleLabel = (self.navigationItem.titleView is? UILabel)!
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont(name: "Verdana", size: 14)
        let childData = NSUserDefaults.standardUserDefaults().objectForKey(Keys.CurrentChildProfile) as! NSData
        let child = NSKeyedUnarchiver.unarchiveObjectWithData(childData) as! Child
        titleLabel.text = child.name
        titleLabel.textAlignment = .Center
        (titleLabel.sizeToFit())
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.navigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "taskDetail":
            //let destinationVC = segue.destinationViewController as! TaskDetailsViewController
            //destinationVC.
            let destinationVC = segue.destinationViewController as! TaskDetailsViewController
            let indexPath = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRowAtIndexPath(indexPath!)
            destinationVC.taskName = cell?.textLabel?.text
            tableView.deselectRowAtIndexPath(indexPath!, animated: false)
            break
        default: break
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func clearDefaults(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: Keys.ChildProfiles)
    }
    
    
    func barButtonItemClicked(sender : UIBarButtonItem) {
        print("clicked button")
    }
    @IBAction func printNSUser(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let childProfiles = defaults.arrayForKey(Keys.ChildProfiles) as? [NSData] {
            print("We had child profiles")
            
            for childData in childProfiles {
                let child = NSKeyedUnarchiver.unarchiveObjectWithData(childData) as? Child
                if child != nil {
                    print("\(child!.name) \(child!.weight) \(child!.birthday.description)")
                }
            }
            
        } else {
            print("We have nothing stored")
        }
    }
}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = tasks[indexPath.row].name
        return cell!
    }
}
