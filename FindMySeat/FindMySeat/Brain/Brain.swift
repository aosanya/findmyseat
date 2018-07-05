//
//  Brain.swift
//  FindMySeat
//
//  Created by Anthony on 28/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import Foundation

class Brain : Codable{
    var decisions : Set<Decision> = Set<Decision>()
    
    init(){
    
    }
    
    func addDecisions(newDecisions : Set<Decision>){
        let sortedDecisions = newDecisions.sorted(by: {$0.hashValue < $1.hashValue})
        for each in sortedDecisions{
            let existing = self.decisions.filter({m in m.states == each.states}).first
            if existing != nil{
                existing!.action = each.action
                existing!.direction = each.direction
                return
            }
            
            each.hashValue = self.newHash()
            self.decisions.insert(each)
        }
    }
    
    private func newHash() -> Int{
        guard self.decisions.count > 0 else{
            return 1
        }
        
        let sortedDecisions = self.decisions.sorted(by: {$0.hashValue < $1.hashValue}).last
        return sortedDecisions!.hashValue + 1
    }
    
    func getDecision(states : Set<States>) -> Decision?{
        let exactMatch = getExactMatch(states: states)
        guard exactMatch == nil else{
            return exactMatch
        }
        
        let superSet = getSuperSet(states: states)
        guard superSet == nil else{
            return superSet
        }
        return nil
    }
    
    private func getExactMatch(states : Set<States>) -> Decision?{
        let sortedStates = states.sorted(by: {$0.set.count > $1.set.count})
        for eachState in sortedStates{
            let exactMatches = self.decisions.filter({m in m.states.set == eachState.set})
            if exactMatches.count > 0{
                let sortedMatches = exactMatches.sorted(by: {$0.hashValue > $1.hashValue})
                return sortedMatches.first
            }
            
            
        }
        return nil
    }
    
    private func getSuperSet(states : Set<States>) -> Decision?{
        let sortedStates = states.sorted(by: {$0.set.count > $1.set.count})
        for eachState in sortedStates{
             let superSets = self.decisions.filter({m in m.states.set .isSuperset(of: eachState.set)})
            
            if superSets.count > 0{
                let sortedMatches = superSets.sorted(by: {$0.hashValue > $1.hashValue})
                return sortedMatches.first
            }
            
        }
        return nil
    }
    
}
