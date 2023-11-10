import Combine
import Foundation
import UIKit

enum CombineError: Error {
    case failed
}

class NetworkLayer {
    func getData(url: String) -> any Publisher<Data, CombineError> {
        guard let url = URL(string: url) else {
            return Fail<Data, CombineError>(error: .failed).eraseToAnyPublisher()
        }
        return Future<Data, CombineError> { promise in
            print("Start Future")
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                guard error == nil else {
                    promise(.failure(.failed))
                    return
                }

                guard let imageData = data else {
                    promise(.failure(.failed))
                    return
                }
                promise(.success(imageData))
            }.resume()
        }.eraseToAnyPublisher()
    }
}

class ViewModel {
    private let layer = NetworkLayer()
    private var store: Set<AnyCancellable> = []

    func loadData(url: String) {
        layer.getData(url: url)
            .sink { complete in
                print(complete)
            } receiveValue: { data in
                let image = UIImage(data: data)
            }.store(in: &store)

    }
}

let viewModel = ViewModel()

viewModel.loadData(url: "https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/23-swift-512.png")
