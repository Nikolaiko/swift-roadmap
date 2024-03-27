//
//  LegacyCar.swift
//  ExampleObservable
//
//  Created by Nikolai Baklanov on 27.03.2024.
//

import Foundation

class LegacyCar: ObservableObject {
    @Published var name: String
    @Published var years: Int

    init(name: String, years: Int) {
        self.name = name
        self.years = years
    }

    func change() {
        name = "New Name"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.years += 1
        }
    }
}
