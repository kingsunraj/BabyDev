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
    var tasks = ["Jump", "Walk", "Talk"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.redColor()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.frame.origin = CGPoint(x: 0, y: 40)
    }
    
    @IBAction func clearDefaults(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nil, forKey: Keys.ChildProfiles)
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
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = tasks[indexPath.row]
        return cell!
    }
}
