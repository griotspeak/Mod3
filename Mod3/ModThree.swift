//
//  ModThree.swift
//  Mod3
//
//  Created by TJ Usiyan on 7/3/14.
//  Copyright (c) 2014 ButtonsAndLights. All rights reserved.
//

import Foundation

enum State : Int {
    case q0 = 0
    case q1
    case q2
    case q3
    func toString() -> String{
        switch self {
        case .q0:
            return "q0"
        case .q1:
            return "q1"
        case .q2:
            return "q2"
        case .q3:
            return "q3"
        }
    }
}

struct DeterministicFiniteStateMachine {
    let table = [
        [State.q0, State.q1],
        [State.q2, State.q0],
        [State.q1, State.q2],
        [State.q3, State.q3],
    ]
    
    func delta(state:State, string:String) -> State {
        if countElements(string) == 0 {
            return .q0
        } else {
            var workingState:State = .q0
            for (index, value) in enumerate(string) {
                workingState = delta(workingState, char: value)
            }
            return workingState
        }
    }
    
    func delta(state:State, char:Character) -> State {
        var charVal:Int
        switch char {
        case "0":
            charVal = 0
        case "1":
            charVal = 1
        default:
            return State.q3
        }
        
        return table[state.toRaw()][charVal]
    }
}

let dfa = DeterministicFiniteStateMachine()