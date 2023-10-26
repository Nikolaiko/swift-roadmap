import UIKit

enum Origin {
    case anadyr
    case omsk
    case pasaden
}

class Person {
    let name: String
    var age: Int
    let origin: Origin

    init(name: String, age: Int, origin: Origin) {
        self.name = name
        self.age = age
        self.origin = origin
    }
}

let person = Person(name: "Sheldon", age: 38, origin: .pasaden)
let namePath: KeyPath<Person, String> = \Person.name
print(person[keyPath: namePath])

let agePath: ReferenceWritableKeyPath<Person, Int> = \Person.age
print(person[keyPath: agePath])

person[keyPath: agePath] = 39


