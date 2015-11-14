//
//  CreateChildProfileViewController.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import UIKit

class CreateChildProfileViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    weak var delegate: CreateChildViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tapGestureRecognizer)
        nameTextField.delegate = self
        weightTextField.delegate = self
        birthdayPicker.datePickerMode = UIDatePickerMode.Date
        self.navigationController?.navigationBarHidden = true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func printNSDefaults(sender: AnyObject) {
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
            print("Nothing stored in defaults")
        }
    }
    
    @IBAction func submitProfileInfo(sender: AnyObject) {
        if nameTextField.text == "" { print("name text field empty"); return }
        if let weight = NSNumberFormatter().numberFromString(weightTextField.text!)?.doubleValue {
            let newChild = Child(name: nameTextField.text!, weight: weight, birthday: birthdayPicker.date)
            
            var profiles = NSUserDefaults.standardUserDefaults().arrayForKey(Keys.ChildProfiles) as? [NSData]
            if profiles == nil {
                var arrayData = [NSData]()
                let archivedData = NSKeyedArchiver.archivedDataWithRootObject(newChild)
                arrayData.append(archivedData)
                NSUserDefaults.standardUserDefaults().setObject(arrayData, forKey: Keys.ChildProfiles)
            } else {
                profiles!.append(NSKeyedArchiver.archivedDataWithRootObject(newChild))
                NSUserDefaults.standardUserDefaults().setObject(profiles!, forKey: Keys.ChildProfiles)
            }
            delegate.presentTasksViewController()
        } else {
            print("Weight invalid")
            return
        }
        //could validate date as well
    }
}

protocol CreateChildViewControllerDelegate: class {
    func presentTasksViewController()
}

extension CreateChildProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case nameTextField: weightTextField.becomeFirstResponder()
        case weightTextField: dismissKeyboard()
        default: break
        }
        return true
    }
}
