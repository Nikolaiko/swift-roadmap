import Foundation
import Combine

var disposeBag: Set<AnyCancellable> = []
let someArray = [1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1, 90]
let arrayPublisher = someArray.publisher

// MARK: 1
//arrayPublisher
//    .filter { value  in value < 5 }
//    .sink { value in
//        print("Filtered value: \(value)")
//    }
//    .store(in: &disposeBag)
//
//let connectable = arrayPublisher.makeConnectable()
//connectable
//    .sink { value in
//        print("Connectable Filtered value: \(value)")
//    }
//    .store(in: &disposeBag)
//
//connectable.connect()


// MARK: 2
//let first = PassthroughSubject<String, Never>()
//let second = PassthroughSubject<String, Never>()
//
//first.combineLatest(second)
//    .sink { tupleValue in
//        print("Tuple : \(tupleValue)")
//    }
//    .store(in: &disposeBag)
//
//
//first.zip(second)
//    .sink { tupleValue in
//        print("Zip Tuple : \(tupleValue)")
//    }
//    .store(in: &disposeBag)
//
//first.send("1")
//second.send("A")
//
//first.send("2")
//first.send("3")
//second.send("B")


//MARK: 3
//arrayPublisher
//    .reduce([Int:Int]()) { accum, value in
//        var next = accum
//        if let current = next[value] {
//            next[value] = current + 1
//        } else {
//            next[value] = 1
//        }
//        return next
//    }
//    .map { dictionary in
//        dictionary.map { $0 }
//    }
//    .sink { value in
//        print(value)
//    }
//    .store(in: &disposeBag)

extension Publisher where Output == Int, Failure == Never {
    func hist() -> AnyPublisher<[(key: Int, value: Int)], Never> {
        self.reduce([Int:Int]()) { accum, value in
            var next = accum
            if let current = next[value] {
                next[value] = current + 1
            } else {
                next[value] = 1
            }
            return next
        }
        .map { dictionary in
            dictionary.map { $0 }
        }
        .eraseToAnyPublisher()
    }
}

arrayPublisher
    .hist()
    .sink { value in
        print(value)
    }
    .store(in: &disposeBag)


struct ModusPublisher<Upstream: Publisher>: Publisher where Upstream.Output: SignedInteger {
    typealias Output = Upstream.Output
    typealias Failure = Upstream.Failure

    let upstream: Upstream
    let modus: Upstream.Output

    func receive<S>(subscriber: S) where S : Subscriber, Upstream.Failure == S.Failure, Upstream.Output == S.Input {
        let bridge = ModusSubscriber(modus: modus, downstream: subscriber)
        upstream.subscribe(bridge)
    }
}

extension ModusPublisher {
    struct ModusSubscriber<S>: Subscriber where S: Subscriber, S.Input == Output, S.Failure == Failure {
        typealias Input = S.Input
        typealias Failure = S.Failure

        let combineIdentifier: CombineIdentifier = CombineIdentifier()

        let modus: S.Input
        let downstream: S

        func receive(completion: Subscribers.Completion<S.Failure>) {
            downstream.receive(completion: completion)
        }

        func receive(subscription: Subscription) {
            downstream.receive(subscription: subscription)
        }

        func receive(_ input: S.Input) -> Subscribers.Demand {
            downstream.receive(input % modus)
        }
    }
}

extension Publisher where Output == Int {
    func modus(mod: Int) -> ModusPublisher<Self> {
        ModusPublisher(upstream: self, modus: mod)
    }
}

arrayPublisher
    .modus(mod: 4)
    .sink { mod in
        print(mod)
    }
    .store(in: &disposeBag)
