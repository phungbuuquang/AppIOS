//
//  ToDo.swift
//  CheckList
//
//  Created by Phung buu quang on 12/8/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import Foundation

struct ToDo {
    var name: String
    var isComplete: Bool = false
    
    init(name: String, isComplete: Bool){
        self.name = name
        self.isComplete = isComplete
    }
}
