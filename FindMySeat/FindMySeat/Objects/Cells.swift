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
    var cellWidth : CGFloat
    var cellHeight : CGFloat
    
    init(area : CGRect, rows : Int, cols : Int, delegate : CellsDelegate?){
        self.area = area
        self.rows = rows
        self.cols = cols
        cellWidth = self.area.width / CGFloat(self.cols)
        cellHeight = self.area.height / CGFloat(self.rows)
        
        
        if delegate != nil{
            self.delegates.append(delegate!)
        }
        
        self.createCells()        
    }
    
    private func createCells(){
        var leftStart = self.area.width * -0.5
        var topStart = self.area.height * -0.5
        
        for i in 0...self.rows - 1{
            if i == 0 {
                topStart = self.area.height * -0.5 + (actualCellHeight(row: 0) * 0.5)
            }
            else{
                topStart = topStart + actualCellHeight(row: i - 1)/2 + actualCellHeight(row: i)/2
            }
                        
            for j in 0...self.cols - 1{
                if j == 0 {
                     leftStart = self.area.width * -0.5  + (actualCellWidth(col: 0) * 0.5)
                }
                else{
                     leftStart = leftStart + actualCellWidth(col: j)
                }
                let size = cellSize(row: i, col: j)
               
                self.addCell(row: i, col: j, size: size, pos: CGPoint(x: leftStart , y: topStart))
            }
        }
    }
    
    private func actualCellHeight(row : Int) -> CGFloat{
        if row % 2 == 0{
            return cellHeight * 0.7
        }
        let diff = cellHeight - cellHeight * 0.7
        
        return cellHeight + diff
    }
    
    private func actualCellWidth( col : Int) -> CGFloat{
        return cellWidth
    }
    
    private func cellSize(row : Int, col : Int) -> CGSize{
        return CGSize(width: actualCellWidth(col: col), height: actualCellHeight(row: row))
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
    
    func relativeCell(cell : Cell, radAngle : CGFloat) -> Cell?{
        let row = Double(cos(radAngle)).rounded()
        let col = Double(sin(radAngle)).rounded()
        
        return relativeCell(cell: cell, row: Int(row), col: Int(col))
    }
    
    func radialCells(cell : Cell, radius : Int) -> [Cell]{
        guard radius > 0 else {
             return [cell]
        }
        
        return self.set.filter({m in m.row >= cell.row - radius && m.row <= cell.row + radius
            && m.col >= cell.col - radius && m.col <= cell.col + radius})
    }
    
    func radialCellsState(cell : Cell, radius : Int) -> States{
        let rCells = self.radialCells(cell: cell, radius: radius)
        let states = rCells.sorted(by: {$0.row < $1.row  && $0.col < $1.col}).enumerated().map{($0, $1.state())}
        return States(set: Set(states.map({m in State(index: m.0, value: m.1)})))
    }
}
