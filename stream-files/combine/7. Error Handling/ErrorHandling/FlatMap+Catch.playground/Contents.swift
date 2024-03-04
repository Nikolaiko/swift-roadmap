import Foundation


// MARK: - Result
struct CharactersResult: Codable, Identifiable {
    let id: Int
    let name: String
    let gender: Gender
}

enum Gender: String, Codable {
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

import Combine


let urlToRequest: [String] = [
    "https://rickandmortyapi.com/api/character/1",
    "https://rickandmortyapi.com/api/character/3",
    "https://rickandmortyapi.com/api/character/2",
]

var store: Set<AnyCancellable> = []

urlToRequest.publisher
    .flatMap { stringValue in
        URLSession.shared.dataTaskPublisher(for: URL(string: stringValue)!)
            .map { $0.data }
            .decode(type: CharactersResult.self, decoder: JSONDecoder())
            .catch { error in
                Just(CharactersResult(id: -1, name: "Default", gender: .unknown))
            }
    }
    .eraseToAnyPublisher()
    .sink { completion in
        print(completion)
    } receiveValue: { value in
        print(value)
    }
    .store(in: &store)






