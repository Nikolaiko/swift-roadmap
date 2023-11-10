import Combine
import Foundation

var store: Set<AnyCancellable> = []

// MARK: - PassthroughSubject
//let passthrought = PassthroughSubject<String, Never>()
//
//passthrought.sink { value in
//    print("Pass value: \(value)")
//}.store(in: &store)
//
//passthrought.send("First")
//sleep(3)
//passthrought.send("Second")
//
//
//print("Second passthrought")
//passthrought.sink { value in
//    print("Pass to second value: \(value)")
//}.store(in: &store)
//
//sleep(1)
//
//passthrought.send("Third")



// MARK: - CurrentValueSubject
//let currentValue = CurrentValueSubject<String, Never>("Initial")
//
//currentValue.sink { value in
//    print("Pass value: \(value)")
//}.store(in: &store)
//
//currentValue.send("First")
//sleep(3)
//currentValue.send("Second")
//
//
//print("Second passthrought")
//currentValue.sink { value in
//    print("Pass to second value: \(value)")
//}.store(in: &store)
//
//sleep(1)
//
//currentValue.send("Third")
