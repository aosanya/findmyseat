//
//  Cell.swift
//  FindMySeat
//
//  Created by Anthony on 21/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit

enum CellObjectType : Int{
    case blueSeat = 1
    
    func image() -> UIImage{
        switch self {
        case .blueSeat:
            return #imageLiteral(resourceName: "seatblue")
        }
    }
    
    func gameObjectType() -> GameObjectType{
        switch self {
        case .blueSeat:
            return GameObjectType.blueSeat
        }
    }

}

class Cell : SKSpriteNode{
    var id : Int
    var col : Int
    var row : Int
    var label : SKLabelNode!
    var object : GameObject?
    var asset : GameObject?
    
    var currentTick : Int = 0
    private var countdownstart : Int = 0
    private var countdowmfrequency : Double = 0
    
    init(id : Int, size : CGSize, row : Int, col : Int){
        self.id = id
        self.row = row
        self.col = col
        super.init(texture: SKTexture(image: #imageLiteral(resourceName: "BlueCell")), color: UIColor.clear, size: size)
        self.addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func addLabel(){
        self.label = SKLabelNode(text: "10")
        self.label.fontColor = UIColor.black
        self.addChild(self.label!)
        self.label.zPosition = self.zPosition  +  1
    }
    
    func text(_ value: String) {
        self.label!.text = value
    }
    
    func countdown(start : Int,  frequency : Double){
        self.countdownstart = start
        self.removeAction(forKey: "countdown")
        self.currentTick = start
        let tickAction = SKAction.run({() in self.tick()})
        let sequenceAction = SKAction.sequence([SKAction.wait(forDuration: frequency), tickAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        self.run(repeatAction, withKey : "countdown")
    }
    
    private func restartCountDown(){
        self.countdown(start: self.countdownstart, frequency: self.countdowmfrequency)
    }
    
    private func tick(){        
        self.text("\(self.currentTick)")
        if self.currentTick == 0 {
            self.removeAction(forKey: "countdown")
        }
        self.currentTick -= 1
    }
    
    func addObject(object : CellObjectType) {
        self.object = GameObject(cellObject: object, size: CGSize(width: self.size.width * 0.75, height: self.size.height * 0.75))
        self.addChild(self.object!)
        self.object!.zPosition = self.zPosition + 2
    }
    
    private func objectState() -> UInt{
        if self.object != nil{
            return self.object!.objectType.stateMask()
        }
        return 0
    }
    
    private func assetState() -> UInt{
        if self.asset != nil{
            return self.asset!.objectType.stateMask()
        }
        return 0
    }
    
    func state() -> UInt{
        return self.objectState() | self.assetState()
    }
}
