import Combine

//Prepare data
let myName = "Nikolai"
let data = ["One", "Two", "Three"]


//Create publisher
let simplePublisher = Just<String>(myName)
let sequencePublisher = data.publisher

//Subscribe
simplePublisher.sink { value in
    print("Just value: \(value)")
}

sequencePublisher.sink { completion in
    switch completion {
    case .finished:
        print("Finished Successfuly")
    case .failure(let error):
        print("Error: \(error)")
    }
} receiveValue: { value in
    print("Sequnce value: \(value)")
}

class User {
    var userName: String

    init(userName: String) {
        self.userName = userName
    }
}

var user = User(userName: "Empty")
simplePublisher.assign(to: \User.userName, on: user)

//Subscription
class Network {
    let requestComplete: PassthroughSubject<String, Never> = .init()

    func send() {
        //Some work
        requestComplete.send("Complete!!!!")
    }
}

class ViewModel {
    let network = Network()
    var subs: Set<AnyCancellable> = []

    init() {
        network.requestComplete.sink { result in
            print("Request result: \(result)")
        }.store(in: &subs)
    }

    func sendRequest() {
        network.send()
    }
}

let viewModel = ViewModel()

viewModel.sendRequest()
viewModel.sendRequest()
viewModel.sendRequest()
print("Test complete")

