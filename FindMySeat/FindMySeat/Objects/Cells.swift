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
                self.addCell(row: i, col: j, size: size, pos: CGPoint(x: leftStart + (CGFloat(j) * size.width), y: topStart + (CGFloat(i) * size.height)))
            }
        }
    }
    
    private func addCell(row : Int, col : Int, size : CGSize, pos : CGPoint){
        let cell = Cell(id : self.set.count + 1, size: size,row: row, col: col)
        cell.position = pos
        self.set.append(cell)
        
        for each in self.delegates{
            each.cellCreated(thisCell: cell)
        }
    }
    
    func getCell(id : Int) -> Cell?{
        return self.set.filter({m in m.id == id}).first
    }
    
    func getColCells(col : Int) -> [Cell]{
        return self.set.filter({m in m.col == col})
    }
    
    func getRowCells(row : Int) -> [Cell]{
        return self.set.filter({m in m.row == row})
    }
    
    func relativeCell(cell : Cell, row : Int, col : Int) -> Cell?{
        return self.set.filter({m in m.row == cell.row + row && m.col == cell.col + col}).first
    }
    
    func radialCells(cell : Cell, radius : Int) -> [Cell]{
        guard radius > 0 else {
             return [cell]
        }
        
        return self.set.filter({m in m.row >= cell.row - radius && m.row <= cell.row + radius
            && m.col >= cell.col - radius && m.col <= cell.col + radius})
    }
}
