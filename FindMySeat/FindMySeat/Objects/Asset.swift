//
//  Asset.swift
//  FindMySeat
//
//  Created by Anthony on 23/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import SpriteKit

enum AssetType : Int{
    case myondiek = 1
    
    func image() -> UIImage{
        switch self {
        case .myondiek:
            return #imageLiteral(resourceName: "ondiek2")
        }
    }
    
    func size() -> CGSize{
        switch self {
        case .myondiek:
            return CGSize(width: 100, height: 100)
        }
    }
    
    func isMine() -> Bool{
        switch self{
        case .myondiek:
            return true
        }
    }
    
    func forwardDirection() -> CGFloat{
        switch self {
        case .myondiek:
            return 180
        }
    }
}

class Asset : SKSpriteNode{
    var type : AssetType
    var cell : Cell
    
    init(type : AssetType, cell : Cell){
        self.type = type
        self.cell = cell
        super.init(texture: SKTexture(image: self.type.image()), color: UIColor.clear, size: self.type.size())
        self.zRotation = angleToRadians(angle: self.type.forwardDirection())
        self.position = self.cell.position
        self.zPosition = self.cell.zPosition + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
