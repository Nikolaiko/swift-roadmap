//
//  ContentView.swift
//  ExampleObservable
//
//  Created by Nikolai Baklanov on 27.03.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            BrandNewView()
            Button(action: {
                test()
            }, label: {
                Text("Test")
            })
        }

    }
}

