//
//  ContentView.swift
//  ExampleObservableNew
//
//  Created by Nikolai Baklanov on 27.03.2024.
//

import SwiftUI
import ComposableArchitecture
import Perception

struct ContentView: View {
    @Perception.Bindable var viewStore: StoreOf<CounterReducer>

    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("Counter: \(viewStore.counter)")
                Button(action: {
                    viewStore.send(.add)
                }, label: {
                    Text("Button1")
                })
                Button(action: {
                    viewStore.send(.sub)
                }, label: {
                    Text("Button2")
                })
            }
        }
        .padding()
    }
}
