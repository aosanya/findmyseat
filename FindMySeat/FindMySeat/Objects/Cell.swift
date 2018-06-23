//
//  Cell.swift
//  FindMySeat
//
//  Created by Anthony on 21/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit


class Cell : SKSpriteNode{
    init(size : CGSize){
        super.init(texture: SKTexture(image: #imageLiteral(resourceName: "BlueCell")), color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
