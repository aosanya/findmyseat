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
    func moveForward(){
        var angle = radiansToAngle(self.zRotation)
        angle += self.assetType.forwardDirection()
        let radAngle = angleToRadians(angle: angle)
        
        let proposedCell = cells.relativeCell(cell: self.cell, radAngle: radAngle)
        guard proposedCell != nil else{
            return
        }
        
        if proposedCell?.asset == nil{
            self.cell = proposedCell!
        }
    }
}
