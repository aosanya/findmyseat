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
    
    override func sceneDidLoad() {
        self.loadCells()
        self.loadSeats()
        self.loadPlayers()
        
        self.move()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

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
        
       for each in self.assets.set {
 //           self.createSampleBrain(asset: each)
//            //if let newCell = self.cells.relativeCell(cell: each.cell, row: -1, col: 0){
//            //    each.cell = newCell
//            //}
//            each.state()
           each.think()
       }
    }
    
    func createSampleBrain(asset : Asset){
        let stateSet = asset.state()
        var decisions = Set<Decision>()
        var index : Int = 0

        for each in stateSet{
            index += 1
            decisions.insert(Decision(index : index, states: each, action: Int(Action.MoveForward.rawValue)))
        }

        let brain = Brain(decisions: decisions)
        UserInfo.brain(brain: brain)
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
