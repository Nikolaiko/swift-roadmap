//
//  ExampleObservableNewApp.swift
//  ExampleObservableNew
//
//  Created by Nikolai Baklanov on 27.03.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct ExampleObservableNewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                viewStore: Store(initialState: CounterReducer.State(), reducer: {
                    CounterReducer()
                })
            )
        }
    }
}
