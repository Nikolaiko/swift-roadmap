import Foundation


@dynamicMemberLookup
struct AbstractExample {
    let exampleField: String
    let otherField: Int

    subscript(dynamicMember member: String) -> String {
        print("Input field: \(member)")
        if member == "userName" {
            return "Nikolai"
        } else {
            return "unknownName"
        }
    }
}


let example = AbstractExample(exampleField: "4", otherField: 3)
print(example.ttt)

@dynamicMemberLookup
struct ViewStore<Value: Equatable> {
    let store: Value

    init(store: Value) {
        self.store = store
    }

    func send() {

    }

    subscript<FieldType>(dynamicMember member: KeyPath<Value, FieldType>) -> FieldType {
        store[keyPath: member]
    }
}

struct State: Equatable {
    let countValue: Int
    let name: String
    let d: Double = 5

    init(countValue: Int, name: String) {
        self.countValue = countValue
        self.name = name
    }
}

let state = State(countValue: 4, name: "Nikolai")
let viewStore = ViewStore(store: state)

print(viewStore.name)
print(viewStore.d)
