//
//  Middleware.swift
//  BaseProject
//
//  Created by HUNGND on 2/27/19.
//  Copyright © 2019 HUNGND. All rights reserved.
//

import ReSwift

/**
 Examples:
 ```
 func logMiddleware(action: Action, context: MiddlewareContext<AppState>) -> Action? {
 print(action)
 return action
 }
 ```
 ```
 func asyncMiddleware(action: Action, context: MiddlewareContext<AppState>) -> Action? {
 DispatchQueue.main.async {
 context.next(action)
 }
 return nil
 }
 ```
 */
typealias LogMiddleware<State: StateType> = (Action, MiddlewareContext<State>) -> Action?

struct MiddlewareContext<State: StateType> {
    
    /// Closure that can be used to emit additional actions
    let dispatch: DispatchFunction
    let getState: () -> State?
    
    /// Closure that can be used forward your action if an async operation is performed.
    /// Just return `nil` in your middleware function in that case.
    let next: DispatchFunction
    
    var state: State? {
        return getState()
    }
}

/// Creates a middlewar function using SimpleMiddleware to create a ReSwift Middleware function.
func createMiddleware<State: StateType>(_ middleware: @escaping LogMiddleware<State>) -> ReSwift.Middleware<State> {
    
    return { dispatch, getState in
        return { next in
            return { action in
                
                let context = MiddlewareContext(dispatch: dispatch, getState: getState, next: next)
                if let newAction = middleware(action, context) {
                    next(newAction)
                }
            }
        }
    }
}
