import Combine

var subs: Set<AnyCancellable> = Set()

let data: Array<Int> = [1,2,3,4,5,6,78,7]
let publisher = data.publisher

/*
publisher.sink { completion in
    switch completion {
    case .finished:
        print("Succesfully finished")
    case .failure(let error):
        print("Completed with error: \(error)")
    }
} receiveValue: { value in
    print("current value: \(value)")
}.store(in: &subs)


class AssignExample {
    var intValue: Int

    init(intValue: Int) {
        self.intValue = intValue
    }
}

let assignExample = AssignExample(intValue: 0)
publisher.assign(to: \AssignExample.intValue, on: assignExample).store(in: &subs)
*/

class CustomSubscriber: Subscriber, Cancellable {
    typealias Input = Int
    typealias Failure = Never

    private var sub: (any Subscription)?

    func startReceive() {
        sub?.request(.max(1))
    }

    // Когда Publisher связывается с Subscriber
    func receive(subscription: Subscription) {
        sub = subscription
    }
    
    // Когда получается сообщение от источника данных
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Custom current value: \(input)")
        return .max(1)
    }
    
    // Когда получается сообщение о завершении передачи
    func receive(completion: Subscribers.Completion<Never>) {
        switch completion {
        case .finished:
            print("Custom Succesfully finished")
        case .failure(let error):
            print("Custom Completed with error: \(error)")
        }
    }
    
    func cancel() {
        sub?.cancel()
    }
}

let customSubscriber = CustomSubscriber()
publisher.subscribe(customSubscriber)

customSubscriber.startReceive()

