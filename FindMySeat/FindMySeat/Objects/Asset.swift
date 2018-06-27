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
    
    func gameObjectType() -> GameObjectType{
        switch self {
        case .myondiek:
            return GameObjectType.myondiek
        }
    }
}

class Asset : GameObject{
    var assetType : AssetType
    var cell : Cell{
        didSet{
            if self.cell.id != oldValue.id{
                self.moveToCell()
                self.cell.asset = self
                oldValue.asset = nil
            }
        }
    }
    
    init(assetType : AssetType, cell : Cell){
        self.assetType = assetType
        self.cell = cell
        super.init(assetType : self.assetType)
        self.cell.asset = self
        self.zRotation = angleToRadians(angle: self.assetType.forwardDirection())
        self.position = self.cell.position
        self.zPosition = self.cell.zPosition + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveToCell(){
        let dist = getDistance(self.position, pointB: self.cell.position)
        let duration = Double(dist) / self.assetType.speed()
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
        angle += self.assetType.forwardDirection()
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
    
    func state(){
        var radialCells1 = cells.radialCells(cell: self.cell, radius: 0)
        let state1 = radialCells1.sorted(by: {$0.row < $1.row  && $0.col < $1.col}).enumerated().map{($0, $1.state())}
        let states1 = state1.map({m in State(index: m.0, value: m.1)})
        
        let radialCells2 = cells.radialCells(cell: self.cell, radius: 1)
        let state2 = radialCells2.sorted(by: {$0.row < $1.row  && $0.col < $1.col}).enumerated().map{($0, $1.state())}
        let states2 = state2.map({m in State(index: m.0, value: m.1)})
        
        let radialCells3 = cells.radialCells(cell: self.cell, radius: 2)
        let state3 = radialCells3.sorted(by: {$0.row < $1.row  && $0.col < $1.col}).enumerated().map{($0, $1.state())}
        let states3 = state3.map({m in State(index: m.0, value: m.1)})
        
        let radialCells4 = cells.radialCells(cell: self.cell, radius: 3)
        let state4 = radialCells4.sorted(by: {$0.row < $1.row  && $0.col < $1.col}).enumerated().map{($0, $1.state())}
        let states4 = state4.map({m in State(index: m.0, value: m.1)})
    }
    
}
