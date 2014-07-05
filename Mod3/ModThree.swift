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

struct Array2D<T> {
    var cols:Int, rows:Int
    var matrix:T[]
    
    
    init(cols:Int, rows:Int, repeatedValue:T) {
        self.cols = cols
        self.rows = rows
        matrix = Array(count:cols*rows, repeatedValue:repeatedValue)
    }
    
    subscript(col:Int, row:Int) -> T {
        get {
            return matrix[cols * row + col]
        }
        set {
            matrix[cols*row+col] = newValue
        }
    }
    
    func colCount() -> Int {
        return self.cols
    }
    
    func rowCount() -> Int {
        return self.rows
    }
}

struct DeterministicFiniteStateMachine {
    
    var table:Array2D<State> {
    get {
        let stateCount = State.q3.toRaw() + 1
        var array = Array2D(cols:128, rows:stateCount, repeatedValue:State.q3)
        
        array[State.q0.toRaw(), 0] = .q0
        array[State.q0.toRaw(), 1] = .q1
        array[State.q1.toRaw(), 0] = .q2
        array[State.q1.toRaw(), 1] = .q0
        array[State.q2.toRaw(), 0] = .q1
        array[State.q2.toRaw(), 1] = .q2
        array[State.q3.toRaw(), 0] = .q3
        array[State.q3.toRaw(), 1] = .q3
        return array
    }
    }
    
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
        let outState = table[state.toRaw(), charVal]
        
        return outState
    }
}

let dfa = DeterministicFiniteStateMachine()