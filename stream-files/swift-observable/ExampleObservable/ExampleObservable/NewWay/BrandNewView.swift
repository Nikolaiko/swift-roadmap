//
//  BrandNewView.swift
//  ExampleObservable
//
//  Created by Nikolai Baklanov on 27.03.2024.
//

import SwiftUI

struct BrandNewView: View {
    let viewModel = BrandNewCar(name: "My", years: 4)

    var body: some View {
        let _ = print("Redraw")

        VStack {
            Text(viewModel.name)
            Button(action: {
                viewModel.change()
            }, label: {
                Text("Change")
            })
        }
    }
}

