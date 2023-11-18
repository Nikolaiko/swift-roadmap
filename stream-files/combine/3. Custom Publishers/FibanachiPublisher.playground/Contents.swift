import Combine

enum FibanachiError: Error {
    case intOverflow
}

struct FibanachiPublisher: Publisher {
    typealias Output = Int
    typealias Failure = FibanachiError

    func receive<S>(subscriber: S) where S : Subscriber, FibanachiError == S.Failure, Int == S.Input {
        let subscription = FibanachiSubscription(subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

class FibanachiSubscription<S: Subscriber>: Subscription where S.Input == Int, FibanachiError == S.Failure {

    private var subscriber: S?

    init(subscriber: S) {
        self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
        print("Demand : \(demand)")
        guard demand > .none else {
            subscriber?.receive(completion: .finished)
            return
        }

        var count = demand
        count -= .max(1)
        subscriber?.receive(0)

        if count == .none {
            subscriber?.receive(completion: .finished)
            return
        }

        count -= .max(1)
        subscriber?.receive(1)
        if count == .none {
            subscriber?.receive(completion: .finished)
            return
        }

        var prev = 0
        var current = 1
        var temp: Int

        while subscriber != nil {
            temp = prev
            prev = current
            
            let result = current.addingReportingOverflow(temp)
            if result.overflow {
                subscriber?.receive(completion: .failure(FibanachiError.intOverflow))
                return
            } else {
                current = result.partialValue
            }

            subscriber?.receive(current)
            count -= .max(1)
            if count == .none {
                subscriber?.receive(completion: .finished)
                return
            }
        }
    }
    
    func cancel() {
        subscriber = nil
    }
}

var subs: Set<AnyCancellable> = []
let fibanachi = FibanachiPublisher()

fibanachi
    .print()
    .prefix(4)
    .sink { completion in
        switch completion {
        case .finished:
            print("Success")
        case .failure(let error):
            print("Error: \(error)")
        }
    } receiveValue: { value in
        print("FValue: \(value)")
    }.store(in: &subs)

