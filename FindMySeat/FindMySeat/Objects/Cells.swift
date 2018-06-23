//
//  Cells.swift
//  FindMySeat
//
//  Created by Anthony on 23/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit

protocol CellsDelegate{
    func cellCreated(thisCell : Cell)
}

class Cells{
    var set : [Cell]! = [Cell]()
    var area : CGRect
    var rows : Int
    var cols : Int
    var delegates = [CellsDelegate]()
    
    init(area : CGRect, rows : Int, cols : Int, delegate : CellsDelegate?){
        self.area = area
        self.rows = rows
        self.cols = cols
        if delegate != nil{
            self.delegates.append(delegate!)
        }
        
        self.createCells()        
    }
    
    private func createCells(){
        let cellWidth = self.area.width / CGFloat(self.cols)
        let cellHeight = self.area.height / CGFloat(self.rows)
        let size = CGSize(width: cellWidth, height: cellHeight)
        
        let leftStart = cellWidth * CGFloat(self.cols - 1) / 2 * -1
        let topStart = cellHeight * CGFloat(self.rows - 1) / 2 * -1
        
        for i in 0...self.rows - 1{
            for j in 0...self.cols - 1{
                self.addCell(size: size, pos: CGPoint(x: leftStart + (CGFloat(j) * size.width), y: topStart + (CGFloat(i) * size.height)))
            }
        }
    }
    
    private func addCell(size : CGSize, pos : CGPoint){
        let cell = Cell(size: size)
        cell.position = pos
        self.set.append(cell)
        
        for each in self.delegates{
            each.cellCreated(thisCell: cell)
        }
    }
}