//
//  States.swift
//  FindMySeat
//
//  Created by Anthony on 26/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import UIKit

class State : Equatable{
    var index : Int
    var value : UInt
    
    init (index : Int, value : UInt){
        self.index = index
        self.value = value
    }
    
    static func == (lhs: State, rhs: State) -> Bool {
        return lhs.index == rhs.index && lhs.value == rhs.value
    }
}










