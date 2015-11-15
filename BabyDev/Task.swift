//
//  Task.swift
//  BabyDev
//
//  Created by Jerry Herrera on 11/14/15.
//  Copyright © 2015 Jerry Herrera. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var minAge: Int
    var maxAge: Int
    var interactive: Bool
    init(name: String, min: Int, max: Int, interactive: Bool) {
        self.name = name
        self.minAge = min
        self.maxAge = max
        self.interactive = interactive
    }
}