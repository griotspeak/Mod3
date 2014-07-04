//
//  ModThree.swift
//  Mod3
//
//  Created by TJ Usiyan on 7/3/14.
//  Copyright (c) 2014 ButtonsAndLights. All rights reserved.
//

import Foundation

enum State {
    case q0
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
        switch state {
        case .q0:
            switch char {
            case "0":
                return .q0
            case "1":
                return .q1
            default:
                return .q3
            }
        case .q1:
            switch char {
            case "0":
                return .q2
            case "1":
                return .q0
            default:
                return .q3
            }
        case .q2:
            switch char {
            case "0":
                return .q1
            case "1":
                return .q2
            default:
                return .q3
            }
        case .q3:
            return .q3
        }
    }
}

let dfa = DeterministicFiniteStateMachine()