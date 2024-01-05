import Foundation
import Combine


// MARK: Simple
//@propertyWrapper
//struct TwelveOrLess {
//    private var realValue: Int
//    private let maxValue: Int
//
//    var wrappedValue: Int {
//        get { realValue }
//        set {
//            if newValue > maxValue {
//                realValue = maxValue
//            } else {
//                realValue = newValue
//            }
//        }
//    }
//
//    init(wrappedValue: Int = 0, maxValue: Int) {
//        self.realValue = wrappedValue
//        self.maxValue = maxValue
//    }
//}
//
//
//class ExampleClass {
//    @TwelveOrLess(maxValue: 20)
//    var serversCount: Int
//}
//
//let example = ExampleClass()
//print(example.serversCount)
//
//example.serversCount = 3
//print(example.serversCount)
//
//example.serversCount = 56
//print(example.serversCount)

// MARK: UserDefaults
//@propertyWrapper
//struct StoredValue<ValueType> {
//
//    private let defaultValue: ValueType
//    private let key: String
//
//    var wrappedValue: ValueType {
//        get {
//            UserDefaults.standard.object(forKey: key) as? ValueType ?? defaultValue
//        }
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: key)
//        }
//    }
//
//    init(defaultValue: ValueType, key: String) {
//        self.defaultValue = defaultValue
//        self.key = key
//    }
//}
//
//class UserDefaultsExample {
//    
//    @StoredValue(defaultValue: "NoUser", key: "user_name")
//    var userName: String
//
//    @StoredValue(defaultValue: 0, key: "user_age")
//    var userAge: Int
//}
//
//let userDefaultExample = UserDefaultsExample()
//print(userDefaultExample.userAge)
//print(userDefaultExample.userName)
//
//
//userDefaultExample.userName = "nikolai"
//print(userDefaultExample.userName)
//print(UserDefaults.standard.object(forKey: "user_name"))

// MARK: Parameters
//@propertyWrapper
//struct DebugableValue<ValueType> {
//
//    private var value: ValueType
//    private let description: String
//
//    var wrappedValue: ValueType {
//        get {
//            print("Getting \(description), value: \(value)")
//            return value
//        }
//        set {
//            value = newValue
//            print("Setting \(description), to value: \(newValue)")
//        }
//    }
//
//    init(wrappedValue: ValueType, description: String) {
//        print("Initializing \(description) with value : \(wrappedValue)")
//        self.value = wrappedValue
//        self.description = description
//    }
//}
//
//
//
//class ParameterExample {
//    func someFunction(@DebugableValue(description: "Some parameter") innerName paramter: Int) {
//        let copyValue = paramter
//    }
//}
//
//let parameterExample = ParameterExample()
//parameterExample.someFunction(innerName: 34)


// MARK: Projected Value

@propertyWrapper
struct CustomBinding<ValueType> {
    private var currentValue: ValueType
    private let subject: CurrentValueSubject<ValueType, Never>

    var wrappedValue: ValueType {
        get { currentValue }
        set {
            currentValue = newValue
            subject.send(newValue)
        }
    }

    init(wrappedValue: ValueType) {
        self.currentValue = wrappedValue
        self.subject = CurrentValueSubject(wrappedValue)
    }

    var projectedValue: AnyPublisher<ValueType, Never> { self.subject.eraseToAnyPublisher() }
}


class ProjectedExample {

    @CustomBinding(wrappedValue: "")
    var importantValue: String
}

class ObserverClass {
    private var disposeBag: Set<AnyCancellable> = []

    let observedPublisher: AnyPublisher<String, Never>

    init(observedPublisher: AnyPublisher<String, Never>) {
        self.observedPublisher = observedPublisher
        self.observedPublisher.sink { completion in
            print(completion)
        } receiveValue: { newValue in
            print("Value: \(newValue)")
        }
        .store(in: &disposeBag)

    }
}

let bindExample = ProjectedExample()
let observer = ObserverClass(observedPublisher: bindExample.$importantValue)

bindExample.importantValue = "New value"

