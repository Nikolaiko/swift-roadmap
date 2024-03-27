//
//  CounterReducer.swift
//  ExampleObservableNew
//
//  Created by Nikolai Baklanov on 27.03.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CounterReducer {

    @ObservableState
    struct State {
        var counter = 0
    }

    enum Action {
        case add
        case sub
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .add:
            state.counter += 1
            return .none
        case .sub:
            state.counter -= 1
            return .none
        }

    }
}
