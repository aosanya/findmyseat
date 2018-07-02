//
//  global.swift
//  FindMySeat
//
//  Created by Anthony on 23/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import UIKit

func angleToRadians(angle : CGFloat) -> CGFloat{
   return (angle * CGFloat(Double.pi)) / CGFloat(180)
}

func radiansToAngle(_ radians : CGFloat) -> CGFloat{
    return (radians * CGFloat(180)) / CGFloat(Double.pi)
}

func getDistance(_ pointA : CGPoint, pointB : CGPoint) -> CGFloat{
    let deltaY = pointA.y - pointB.y
    let deltaX = pointA.x - pointB.x
    return sqrt(pow(deltaX, 2) + pow(deltaY, 2))
}

func getRadAngle(_ pointA : CGPoint, pointB : CGPoint) -> Float{
    let deltaY = Float(pointA.y - pointB.y)
    let deltaX = Float(pointA.x - pointB.x)
    return atan2f(deltaY,deltaX)
}
