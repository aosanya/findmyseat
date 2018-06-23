//
//  Cell.swift
//  FindMySeat
//
//  Created by Anthony on 21/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit


class Cell : SKSpriteNode{
    var label : SKLabelNode!
    
    init(size : CGSize){
        super.init(texture: SKTexture(image: #imageLiteral(resourceName: "BlueCell")), color: UIColor.clear, size: size)
        self.addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLabel(){
        self.label = SKLabelNode(text: "10")
        self.label.fontColor = UIColor.black
        self.addChild(self.label!)
        self.label.zPosition = self.zPosition  +  1
    }
}
