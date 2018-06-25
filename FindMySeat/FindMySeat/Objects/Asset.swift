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
    
    func speed() -> Double{
        switch self {
        case .myondiek:
            return 50
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
    var cell : Cell{
        didSet{
            if self.cell.id != oldValue.id{
                self.moveToCell()
            }
        }
    }
    
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
    
    func moveToCell(){
        let dist = getDistance(self.position, pointB: self.cell.position)
        let duration = Double(dist) / self.type.speed()
        let moveAction = SKAction.move(to: self.cell.position, duration: duration)
        let removeWalking = SKAction.run({() in self.removeAction(forKey: "walking")})
        let sequence = SKAction.sequence([moveAction, removeWalking])
        self.run(sequence, withKey : "moving")
        self.walkAnimation()
        self.faceToCell()
    }
    
    func faceToCell(){
        var radAngle = CGFloat(getRadAngle(self.position, pointB: self.cell.position))
        var angle = radiansToAngle(radAngle)
        angle += self.type.forwardDirection()
        radAngle = angleToRadians(angle: angle)
        self.zRotation = angle
    }
    
    private func walkAnimation(){
        let walkAtlas = SKTextureAtlas(named: "ondiek")
        var walkFrames = [SKTexture]()
        
        let images  = [Int](arrayLiteral: 2,3,2,1)
        for  each in images{
            let walkTextureName = "ondiek\(each)"
            walkFrames.append(walkAtlas.textureNamed(walkTextureName))
        }
        
        let walkAction = SKAction.animate(with: walkFrames, timePerFrame: 0.15)
        self.run(SKAction.repeatForever(walkAction), withKey : "walking")
    }
}
