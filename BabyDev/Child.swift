//
//  Child.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import Foundation

class Child: NSObject, NSCoding {
    var name: String
    var weight: Double
    var birthday: NSDate
    init(name: String, weight: Double, birthday: NSDate) {
        self.name = name
        self.weight = weight
        self.birthday = birthday
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey(Keys.ChildName) as! String
        //self.weight = aDecoder.decodeObjectForKey(Keys.ChildWeight) as! Double
        self.weight = aDecoder.decodeDoubleForKey(Keys.ChildWeight) as! Double
        self.birthday = aDecoder.decodeObjectForKey(Keys.ChildBirthday) as! NSDate
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: Keys.ChildName)
        aCoder.encodeDouble(weight, forKey: Keys.ChildWeight)
        aCoder.encodeObject(birthday, forKey: Keys.ChildBirthday)
    }
}