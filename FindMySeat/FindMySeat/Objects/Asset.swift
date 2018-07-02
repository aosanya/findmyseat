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
        //self.zRotation = angleToRadians(angle: self.assetType.forwardDirection())
        self.position = self.cell.position
        self.zPosition = self.cell.zPosition + 10
        self.faceUp()
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
    
    private func faceUp(){
        self.zRotation = angleToRadians(angle: 180)
    }
    
    func faceToCell(){
        var radAngle = CGFloat(getRadAngle(self.position, pointB: self.cell.position))
        var angle = radiansToAngle(radAngle)
        angle += 270
        radAngle = angleToRadians(angle: angle)
        self.zRotation = radAngle
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
    
    func think(){
        let brain = UserInfo.brain()
        guard brain != nil else {
            return
        }
        if let decision = brain?.getDecision(states: self.state()){
            performDecision(decision: decision)
        }
    }
    
    func performDecision(decision : Decision) {
        performAction(action: Action(rawValue: UInt(decision.action)))
    }
    
    func performAction(action : Action?) {
        guard action != nil else {
            return
        }
        
        switch action! {
        case Action.MoveForward:
            self.moveForward()
        }
        
    }
    
    func state() -> Set<States>{
        var stateSet = Set<States>()
        stateSet.insert(cells.radialCellsState(cell: self.cell, radius: 0))
        stateSet.insert(cells.radialCellsState(cell: self.cell, radius: 1))
        stateSet.insert(cells.radialCellsState(cell: self.cell, radius: 2))
        stateSet.insert(cells.radialCellsState(cell: self.cell, radius: 3))
        

        return stateSet
        
        
    }
    
}
