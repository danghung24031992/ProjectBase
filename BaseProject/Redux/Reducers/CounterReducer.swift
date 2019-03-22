//
//  CounterReducer.swift
//  BaseProject
//
//  Created by HUNGND on 2/27/19.
//  Copyright © 2019 HUNGND. All rights reserved.
//

import ReSwift

// the reducer is responsible for evolving the application state based
// on the actions it receives
func counterReducer(action: Action, state: AppState?) -> AppState {
    // if no state has been provided, create the default state
    var state = state ?? AppState()
    
    switch action {
    case _ as CounterActionIncrease:
        state.counter += 1
    case _ as CounterActionDecrease:
        state.counter -= 1
    default:
        break
    }
    
    return state
}
