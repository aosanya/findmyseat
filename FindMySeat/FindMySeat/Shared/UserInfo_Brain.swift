//
//  UserInfo_Brain.swift
//  FindMySeat
//
//  Created by Anthony on 28/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import Foundation
protocol UserInfo_Brain {
    
}


extension UserInfo : UserInfo_Brain  {
    static func brain(brain : Brain){
        let jsonEncoder = JSONEncoder()
        var jsonData : Data? = nil
        do {
            jsonData =  try jsonEncoder.encode(brain)
        } catch {

        }
        UserDefaults.standard.set(jsonData!, forKey: "brain")
    }
    
    static func brain() -> Brain?{
        if let brainData = UserDefaults.standard.value(forKey: "brain") as? Data{
            do {
                let brain = try JSONDecoder().decode(Brain.self, from: brainData)
                return brain
            } catch {
                return nil
            }
        }
        else{
            return nil
        }
    }
    
    
}

