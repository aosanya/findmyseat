//
//  GameScene.swift
//  FindMySeat
//
//  Created by Anthony on 21/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , CellsDelegate {
    var cells : Cells!
    
    override func sceneDidLoad() {
       self.loadCells()
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
        self.cells = Cells(area: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), rows: 8, cols: 8, delegate: self)
    }
    
    func cellCreated(thisCell: Cell) {
        self.addChild(thisCell)
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
