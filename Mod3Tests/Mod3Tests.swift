//
//  Mod3Tests.swift
//  Mod3Tests
//
//  Created by TJ Usiyan on 7/3/14.
//  Copyright (c) 2014 ButtonsAndLights. All rights reserved.
//

import XCTest
import Mod3

class DeterministicFiniteStateMachineTests: XCTestCase {
    let dfa = DeterministicFiniteStateMachine()
    
    func test0() {
        let state = dfa.delta(State.q0, string:"000000")
        XCTAssertEqual(state.toString(), State.q0.toString())
    }
    func test1() {
        let state = dfa.delta(State.q0, string:"0000001")
        XCTAssertNotEqual(state.toString(), State.q0.toString())
    }
    func test2() {
        let state = dfa.delta(State.q0, string:"0000010")
        XCTAssertNotEqual(state.toString(), State.q0.toString())
    }
    func test3() {
        let state = dfa.delta(State.q0, string:"000011")
        XCTAssertEqual(state.toString(), State.q0.toString())
    }
    func test4() {
        let state = dfa.delta(State.q0, string:"00000100")
        XCTAssertNotEqual(state.toString(), State.q0.toString())
    }
    func test5() {
        let state = dfa.delta(State.q0, string:"000000101")
        XCTAssertNotEqual(state.toString(), State.q0.toString())
    }
    func test6() {
        let state = dfa.delta(State.q0, string:"0000000110")
        XCTAssertEqual(state.toString(), State.q0.toString())
    }
    func test7() {
        let state = dfa.delta(State.q0, string:"0000000111")
        XCTAssertNotEqual(state.toString(), State.q0.toString())
    }
    func test8() {
        let state = dfa.delta(State.q0, string:"000000001000")
        XCTAssertNotEqual(state.toString(), State.q0.toString())
    }
    func test9() {
        let state = dfa.delta(State.q0, string:"000000001001")
        XCTAssertEqual(state.toString(), State.q0.toString())
    }
    
    func test97() {
        let state = dfa.delta(State.q0, string:"00001100001")
        XCTAssertNotEqual(state.toString(), State.q0.toString())
    }
    func test98() {
        let state = dfa.delta(State.q0, string:"0000001100010")
        XCTAssertNotEqual(state.toString(), State.q0.toString())
    }
    func test99() {
        let state = dfa.delta(State.q0, string:"000000001100011")
        XCTAssertEqual(state.toString(), State.q0.toString())
    }
}


class Mod3FilterTests: XCTestCase {
    func testCases() {
        let string =
        "000000000000000\n000000000000001\n000000000000010\n000000000000011\n000000000000100\n000000000000101\n000000000000110\n000000000000111\n000000000001000\n000000000001001\n000000001100001\n000000001100010\n000000001100011"
        
        let expected = "000000000000000\n000000000000011\n000000000000110\n000000000001001\n000000001100011"
        XCTAssertEqual(Mod3Filter().filter(string), expected)
    }
}