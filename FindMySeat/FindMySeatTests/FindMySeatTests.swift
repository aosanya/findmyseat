//
//  FindMySeatTests.swift
//  FindMySeatTests
//
//  Created by Anthony on 21/06/2018.
//  Copyright © 2018 CodeVald. All rights reserved.
//

import XCTest
@testable import FindMySeat

class FindMySeatTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testThink() {
        var decisions = Set<Decision>()
        var decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisions.insert(Decision(index: 1, states: States(set: decisionStates), action: 1, direction: CGVector(dx: 1, dy: 0)))
        
        decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 2))
        decisions.insert(Decision(index: 2, states: States(set: decisionStates), action: 2, direction: CGVector(dx: 1, dy: 0)))

        decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 3))
        decisions.insert(Decision(index: 3, states: States(set: decisionStates), action: 3, direction: CGVector(dx: 1, dy: 0)))
        
        let brain = Brain()
        brain.addDecisions(newDecisions: decisions)
        
        var testDecisionStates = Set<State>()
        testDecisionStates.insert(State(index: 1, value: 1))
        var assetStates = Set<States>()
        assetStates.insert(States(set: testDecisionStates))
        var decision = brain.getDecision(states: assetStates)
        XCTAssert(decision != nil)
        XCTAssert(decision?.action == 1)
        
        
        testDecisionStates = Set<State>()
        testDecisionStates.insert(State(index: 1, value: 2))
        assetStates = Set<States>()
        assetStates.insert(States(set: testDecisionStates))
        decision = brain.getDecision(states: assetStates)
        XCTAssert(decision != nil)
        XCTAssert(decision?.action == 2)
        
        
        testDecisionStates = Set<State>()
        testDecisionStates.insert(State(index: 1, value: 3))
        assetStates = Set<States>()
        assetStates.insert(States(set: testDecisionStates))
        decision = brain.getDecision(states: assetStates)
        XCTAssert(decision != nil)
        XCTAssert(decision?.action == 3)
    }
    
    func testThink2() {
        var decisions = Set<Decision>()
        var decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisions.insert(Decision(index: 1, states: States(set: decisionStates), action: 1, direction: CGVector(dx: 1, dy: 0)))
        
        decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisionStates.insert(State(index: 2, value: 2))
        decisions.insert(Decision(index: 2, states: States(set: decisionStates), action: 2, direction: CGVector(dx: 1, dy: 0)))
        
        decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisionStates.insert(State(index: 2, value: 2))
        decisionStates.insert(State(index: 3, value: 3))
        decisions.insert(Decision(index: 3, states: States(set: decisionStates), action: 3, direction: CGVector(dx: 1, dy: 0)))
        
        let brain = Brain()
        brain.addDecisions(newDecisions: decisions)
        
        var testDecisionStates = Set<State>()
        testDecisionStates.insert(State(index: 1, value: 1))
        var assetStates = Set<States>()
        assetStates.insert(States(set: testDecisionStates))
        var decision = brain.getDecision(states: assetStates)
        XCTAssert(decision != nil)
        XCTAssert(decision?.action == 1)
        
        
        testDecisionStates = Set<State>()
        testDecisionStates.insert(State(index: 1, value: 1))
        testDecisionStates.insert(State(index: 2, value: 2))
        assetStates = Set<States>()
        assetStates.insert(States(set: testDecisionStates))
        decision = brain.getDecision(states: assetStates)
        XCTAssert(decision != nil)
        XCTAssert(decision?.action == 2)
        
        
        testDecisionStates = Set<State>()
        testDecisionStates.insert(State(index: 1, value: 1))
        testDecisionStates.insert(State(index: 2, value: 2))
        testDecisionStates.insert(State(index: 3, value: 3))
        assetStates = Set<States>()
        assetStates.insert(States(set: testDecisionStates))
        decision = brain.getDecision(states: assetStates)
        XCTAssert(decision != nil)
        XCTAssert(decision?.action == 3)
    }
    
    func testThinkSuperSet() {
        var decisions = Set<Decision>()
        var decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisions.insert(Decision(index: 1, states: States(set: decisionStates), action: 1, direction: CGVector(dx: 1, dy: 0)))
        
        decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisionStates.insert(State(index: 2, value: 2))
        decisions.insert(Decision(index: 2, states: States(set: decisionStates), action: 2, direction: CGVector(dx: 1, dy: 0)))
        
        decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisionStates.insert(State(index: 2, value: 2))
        decisionStates.insert(State(index: 3, value: 3))
        decisions.insert(Decision(index: 3, states: States(set: decisionStates), action: 3, direction: CGVector(dx: 1, dy: 0)))
        
        decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisionStates.insert(State(index: 2, value: 4))
        decisionStates.insert(State(index: 3, value: 3))
        decisions.insert(Decision(index: 4, states: States(set: decisionStates), action: 3, direction: CGVector(dx: 1, dy: 0)))
        
        decisionStates = Set<State>()
        decisionStates.insert(State(index: 1, value: 1))
        decisionStates.insert(State(index: 2, value: 5))
        decisionStates.insert(State(index: 3, value: 6))
        decisions.insert(Decision(index: 5, states: States(set: decisionStates), action: 3, direction: CGVector(dx: 1, dy: 0)))
        
        let brain = Brain()
        brain.addDecisions(newDecisions: decisions)
        
        var testDecisionStates = Set<State>()
        testDecisionStates.insert(State(index: 2, value: 2))
        var assetStates = Set<States>()
        assetStates.insert(States(set: testDecisionStates))
        var decision = brain.getDecision(states: assetStates)
        XCTAssert(decision != nil)
        XCTAssert(decision?.action == 3, "Was expecting 3 but found \(decision?.action)")
        
        testDecisionStates = Set<State>()
        testDecisionStates.insert(State(index: 1, value: 1))
        testDecisionStates.insert(State(index: 2, value: 4))
        assetStates = Set<States>()
        assetStates.insert(States(set: testDecisionStates))
        decision = brain.getDecision(states: assetStates)
        XCTAssert(decision != nil)
        XCTAssert(decision?.action == 3)
    }
}
