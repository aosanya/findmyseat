//
//  Asset_Actions.swift
//  FindMySeat
//
//  Created by Anthony on 29/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import Foundation


protocol Asset_Actions {
    
}

extension Asset : Asset_Actions{
    func move(decision : Decision){
        let proposedCell = cells.relativeCell(cell: self.cell, row: Int(decision.direction.dy), col: Int(decision.direction.dx))
        guard proposedCell != nil else{
            return
        }
        
        if proposedCell?.asset == nil{
            self.cell = proposedCell!
        }
    }
}
