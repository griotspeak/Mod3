//
//  ModThree.swift
//  Mod3
//
//  Created by TJ Usiyan on 7/3/14.
//  Copyright (c) 2014 ButtonsAndLights. All rights reserved.
//

import Foundation

protocol DeterministicFiniteAutomataState : Equatable {
/** @todo Make these variables when supported 2014-07-06 */
    class func startState() -> Self
    class func acceptanceStates() -> [Self]
    class func stateCount() -> Int
    class func tableRepeatedValueState() -> Self
}

protocol TransitionFunction {
    typealias State:DeterministicFiniteAutomataState
    func apply(state:State, char:Character) -> State
    func apply(state:State, string:String) -> State
}

class DeterministicFiniteAutomata< T : TransitionFunction> {
    
    let transitionFunction:T
    let acceptanceStates:[T.State] = []
    
    init(transitionFunction:T) {
        self.acceptanceStates = T.State.acceptanceStates()
        self.transitionFunction = transitionFunction
    }
    
    func accepts(state:T.State, string:String) -> Bool {
        return contains(self.acceptanceStates, self.transitionFunction.apply(state, string: string))
    }
}

enum Mod3State : Int, DeterministicFiniteAutomataState {
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
    
    static func startState() -> Mod3State {
        return .q0
    }
    static func acceptanceStates() -> [Mod3State] {
        return[.q0]
    }
    
    static func stateCount() -> Int {
        return 4
    }
    
    static func tableRepeatedValueState() -> Mod3State {
        return .q3
    }
}


class Mod3TransitionFunction : TransitionFunction {
    
    let table:[[Mod3State]]
    class func createLargeStateTable<State:DeterministicFiniteAutomataState>(alphabetOrdinality:Int, repeatedValue:State) -> [[State]] {
        return Array<[State]>(count: 128, repeatedValue: Array<State>(count: State.stateCount(), repeatedValue:repeatedValue))
    }
    
    init() {
        self.table = []
        var array = Mod3TransitionFunction.createLargeStateTable(128, repeatedValue: Mod3State.tableRepeatedValueState())
        array[Mod3State.q0.toRaw()][0] = .q0
        array[Mod3State.q0.toRaw()][1] = .q1
        array[Mod3State.q1.toRaw()][0] = .q2
        array[Mod3State.q1.toRaw()][1] = .q0
        array[Mod3State.q2.toRaw()][0] = .q1
        array[Mod3State.q2.toRaw()][1] = .q2
        array[Mod3State.q3.toRaw()][0] = .q3
        array[Mod3State.q3.toRaw()][1] = .q3
        self.table = array
    }
    
    func apply(state:Mod3State, char:Character) -> Mod3State {
        var charVal:Int
        switch char {
        case "0":
            charVal = 0
        case "1":
            charVal = 1
        default:
            return Mod3State.q3
        }
        let outState = table[state.toRaw()][charVal]
        
        return outState
    }
    func apply(state:Mod3State, string:String) -> Mod3State {
        // calls Character delta
        if countElements(string) == 0 {
            return state
        } else {
            var workingState:Mod3State = Mod3State.startState()
            for (index, value) in enumerate(string) {
                workingState = apply(workingState, char: value)
            }
            return workingState
        }
    }
}

class Mod3Filter {
    let dfa:DeterministicFiniteAutomata<Mod3TransitionFunction> = DeterministicFiniteAutomata<Mod3TransitionFunction>(transitionFunction: Mod3TransitionFunction())
    func filter(input:String) -> String {
        let string = input.bridgeToObjectiveC()
        let splitString:[String] = string.componentsSeparatedByString("\n") as [String]
        var output = String()
        let count = countElements(splitString)
        for (index, value) in enumerate(splitString) {
            if dfa.accepts(Mod3State.startState(), string: value) {
                output += value
                
                if index+1 != count {
                    output += "\n"
                }
            }
        }
        
        return output
    }
}