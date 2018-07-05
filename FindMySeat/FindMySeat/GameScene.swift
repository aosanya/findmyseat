//
//  GameScene.swift
//  FindMySeat
//
//  Created by Anthony on 21/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit
import GameplayKit

var cells : Cells!


class GameScene: SKScene , CellsDelegate, AssetsDelegate {
    var assets : Assets!
    var selectedAsset : Asset?
    var selectedCell : Cell?{
        didSet{
            guard self.selectedCell != nil else {
                if oldValue != nil{
                    oldValue!.actionstate = CellState.empty
                }
                return
            }
            
            if selectedCell != oldValue{
                selectedCell?.actionstate =  CellState.selected
                if oldValue != nil{
                    oldValue?.actionstate = CellState.empty
                }
            }
        }
    }
    
    override func sceneDidLoad() {
        self.loadCells()
        self.loadSeats()
        self.loadPlayers()
        
        self.move()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for eachTouch in touches{
            for eachNode in self.nodes(at: eachTouch.location(in: self)){
                if let thisAsset = eachNode as? Asset{
                    if thisAsset.isPerformingAction() == false{
                        self.selectedAsset = thisAsset
                        self.isPaused = true
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for eachTouch in touches{
            for eachNode in self.nodes(at: eachTouch.location(in: self)){
                if let thisCell = eachNode as? Cell{
                    if self.selectedAsset != nil{
                        let rel = self.selectedAsset!.cell.relativity(cell: thisCell)
                        if rel.0 == 0 && rel.1 == 0{
                            return
                        }
                        
                        var row = rel.0
                        var col = rel.1
                        
                        if row < -1{row = -1}
                        if row > 1{row = 1}
                        if col < -1{col = -1}
                        if col > 1{col = 1}
                        let actualSelection = cells.relativeCell(cell: self.selectedAsset!.cell, row: row, col: col)
                        
                        self.selectedCell = actualSelection
                        
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.selectedAsset != nil && self.selectedCell != nil{
            let rel = self.selectedAsset!.cell.relativity(cell: self.selectedCell!)
            self.addMoveDecision(asset: self.selectedAsset!, direction: CGVector(dx: rel.1, dy: rel.0))
        }
        self.selectedCell = nil
        self.selectedAsset = nil
        self.isPaused = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    func getAction(fromCell : Cell, toCell : Cell){
        
    }
    
    func loadCells(){
        cells = Cells(area: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), rows: 14, cols: 8, delegate: self)
    }
    
    func loadPlayers(){
        self.assets = Assets(cells: cells, delegate: self)
    }
    
    func loadSeats(){
        func loadSet(cells : [Cell]){
            for each in cells{
                if each.row % 2 == 1{
                    each.addObject(object: CellObjectType.blueSeat)
                }
            }
        }
        
        loadSet(cells: cells.getColCells(col: 0))
        loadSet(cells: cells.getColCells(col: 1))
        loadSet(cells: cells.getColCells(col: 3))
        loadSet(cells: cells.getColCells(col: 4))

        loadSet(cells: cells.getColCells(col: 6))
        loadSet(cells: cells.getColCells(col: 7))
    }
    
    func cellCreated(thisCell: Cell) {
        self.addChild(thisCell)
        thisCell.countdown(start: 10, frequency: 1)
    }
    
    func assetCreated(thisAsset: Asset) {
         self.addChild(thisAsset)
    }
    
    func move(){
        
      // for each in self.assets.set {
 //           self.createSampleBrain(asset: each)
//            //if let newCell = self.cells.relativeCell(cell: each.cell, row: -1, col: 0){
//            //    each.cell = newCell
//            //}
//            each.state()
         //  each.think()
     //  }
    }
    
    func createSampleBrain(asset : Asset){
        let stateSet = asset.state()
        var decisions = Set<Decision>()
        var index : Int = 0

        for each in stateSet{
            index += 1
            decisions.insert(Decision(index : index, states: each, action: Action.Move.rawValue, direction : CGVector(dx: 0, dy: 1)))
        }

        let brain = Brain()
        brain.addDecisions(newDecisions: decisions)
        UserInfo.brain(brain: brain)
    }
    
    func addMoveDecision(asset : Asset, direction : CGVector){
        let stateSet = asset.state()
        var decisions = Set<Decision>()
        var index : Int = 0
        
        for each in stateSet{
            index += 1
            decisions.insert(Decision(index : index, states: each, action: Action.Move.rawValue, direction : direction))
        }
        
        if let brain = UserInfo.brain(){
            brain.addDecisions(newDecisions: decisions)
            UserInfo.brain(brain: brain)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
