//
//  ContentView.swift
//  KeyPathSwiftUI
//
//  Created by Nikolai Baklanov on 26.10.2023.
//

import SwiftUI

let persons: [Person] = [
    Person(name: "Sheldon", age: 38),
    Person(name: "Leonard", age: 38),
    Person(name: "Hovard", age: 38),
]

let names = persons.map(\.name)


struct ContentView: View {
    var body: some View {
        List {
            ForEach(persons, id: \Person.name) { current in
                Text("Name : \(current.name)")
            }
        }
    }
}
