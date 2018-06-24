//
//  Cell.swift
//  FindMySeat
//
//  Created by Anthony on 21/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit


class Cell : SKSpriteNode{
    var col : Int
    var row : Int
    var label : SKLabelNode!
    var currentTick : Int = 0
    private var countdownstart : Int = 0
    private var countdowmfrequency : Double = 0
    
    init(size : CGSize, row : Int, col : Int){
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
}
