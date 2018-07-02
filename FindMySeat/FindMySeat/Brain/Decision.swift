//
//  Decision.swift
//  FindMySeat
//
//  Created by Anthony on 27/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

enum Action : UInt{
    case MoveForward
}

import UIKit

private let Decision_states = "Decision_states"
private let Decision_action = "Decision_action"

class Decision : Hashable , Codable{
    var hashValue: Int
    
    static func == (lhs: Decision, rhs: Decision) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var states : States
    var action : Int
    
    init(index : Int, states : States, action : Int){
        self.hashValue = index
        self.action = action
        self.states = states
    }
    
    
}
