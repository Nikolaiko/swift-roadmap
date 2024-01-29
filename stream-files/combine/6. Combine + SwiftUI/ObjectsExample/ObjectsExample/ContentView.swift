//
//  ContentView.swift
//  ObjectsExample
//
//  Created by Nikolai Baklanov on 29.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()

    var body: some View {
        let _ = print("Redraw")
        VStack {
            Text("Hello, world! : \(viewModel.x)")
        }
        .padding()
        .onAppear {
            viewModel.startChange()
        }
    }
}

