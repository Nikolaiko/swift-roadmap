//
//  ViewModel.swift
//  ObjectsExample
//
//  Created by Nikolai Baklanov on 29.01.2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var x = 5
    @Published var y = 6    

    func startChange() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.x += 4
            print("X: \(self.x)")


        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.y += 4
            print("y: \(self.y)")
            


        }
    }
}
