//
//  GameObject.swift
//  FindMySeat
//
//  Created by Anthony on 26/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit

enum GameObjectType : UInt{
    case myondiek = 1
    case blueSeat = 2
    
    func stateMask() -> UInt{
        return 1 << self.rawValue
    }
    
}

class GameObject : SKSpriteNode{
    var objectType : GameObjectType
    
    init(texture: SKTexture?, color: UIColor, size: CGSize, objectType : GameObjectType) {
        self.objectType = objectType
        super.init(texture: texture, color: color, size: size)
    }
    
    init(assetType : AssetType) {
        self.objectType = assetType.gameObjectType()
        super.init(texture: SKTexture(image: assetType.image()), color: UIColor.clear, size: assetType.size())
    }
    
    init(cellObject : CellObjectType, size : CGSize) {
        self.objectType = cellObject.gameObjectType()
        super.init(texture: SKTexture(image: cellObject.image()), color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
