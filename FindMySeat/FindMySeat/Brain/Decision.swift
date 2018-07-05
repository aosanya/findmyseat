//
//  Decision.swift
//  FindMySeat
//
//  Created by Anthony on 27/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

enum Action : UInt{
    case Move
}

import UIKit


class Decision : Hashable , Codable{
    var hashValue: Int
    
    static func == (lhs: Decision, rhs: Decision) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var states : States
    var action : UInt
    var direction : CGVector
    
    init(index : Int, states : States, action : UInt, direction : CGVector){
        self.hashValue = index
        self.action = action
        self.states = states
        self.direction = direction
    }
    
    
}
