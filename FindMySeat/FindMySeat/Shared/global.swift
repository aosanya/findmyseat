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
