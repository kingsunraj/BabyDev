//
//  TaskDetailsViewController.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController {
    @IBOutlet weak var taskNameLabel: UILabel! {
        didSet {
            taskNameLabel.text = taskName
        }
    }
    var taskName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameLabel.sizeToFit()
    }

}
