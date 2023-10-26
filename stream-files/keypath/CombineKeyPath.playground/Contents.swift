import UIKit
import Combine


class Person {
    var age: Int {
        didSet {
            print("Set new")
        }
    }

    init(age: Int) {
        self.age = age
    }
}


var storage: Set<AnyCancellable> = []
var person = Person(age: 38)

person.age = 39

print(person.age)

Just<Int>(7).assign(to: \Person.age, on: person).store(in: &storage)
print(person.age)


