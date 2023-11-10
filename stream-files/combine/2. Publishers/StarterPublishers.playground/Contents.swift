import Combine
import Foundation
import UIKit

let data = ["One", "Two", "Three"]
var store: Set<AnyCancellable> = []

enum CombineError: Error {
    case failed
}

//// MARK: - Just
//let just = Just("First Message")
//
//just.sink { value in
//    print("Just value: \(value)")
//}.store(in: &store)
//
//// MARK: - Sequence
//data.publisher.sink { value in
//    print("Sequence value: \(value)")
//}.store(in: &store)
//
//
////MARK: - Future
//let future = Future<UIImage, CombineError> { promise in
//    print("Start Future")
//    let url = URL(string: "https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/23-swift-512.png")!
//    URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
//        guard error == nil else {
//            promise(.failure(.failed))
//            return
//        }
//
//        guard let imageData = data else {
//            promise(.failure(.failed))
//            return
//        }
//        promise(.success(UIImage(data: imageData)!))
//    }.resume()
//}
//
//future.sink { completion in
//    switch completion {
//    case .finished:
//        print("Success")
//    case .failure(let someError):
//        print("Errror :\(someError)")
//    }
//} receiveValue: { image in
//    let res = image
//}.store(in: &store)
//
//sleep(3)
//
//
//future.sink { completion in
//    switch completion {
//    case .finished:
//        print("Success")
//    case .failure(let someError):
//        print("Errror :\(someError)")
//    }
//} receiveValue: { image in
//    let res = image
//}.store(in: &store)
//
//// MARK: - Deferred
//let deferred = Deferred {
//    print("Start Deferred")
//    return Future<UIImage, CombineError> { promise in
//        print("Start Deferred Future")
//        let url = URL(string: "https://cdn4.iconfinder.com/data/icons/social-media-logos-6/512/23-swift-512.png")!
//        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
//            guard error == nil else {
//                promise(.failure(.failed))
//                return
//            }
//
//            guard let imageData = data else {
//                promise(.failure(.failed))
//                return
//            }
//            promise(.success(UIImage(data: imageData)!))
//        }.resume()
//    }
//}
//
//deferred.sink { completion in
//    switch completion {
//    case .finished:
//        print("Success")
//    case .failure(let someError):
//        print("Errror :\(someError)")
//    }
//} receiveValue: { image in
//    let res = image
//}.store(in: &store)
//
//sleep(3)
//
//deferred.sink { completion in
//    switch completion {
//    case .finished:
//        print("Success")
//    case .failure(let someError):
//        print("Errror :\(someError)")
//    }
//} receiveValue: { image in
//    let res = image
//}.store(in: &store)


// //MARK: - Empty
//let empty = Empty<String, CombineError>()
//
//empty.sink { completion in
//    switch completion {
//    case .finished:
//        print("Success")
//    case .failure(let someError):
//        print("Errror :\(someError)")
//    }
//} receiveValue: { value in
//    print("Empty: \(value)")
//}.store(in: &store)

//MARK: - Fail
//let fail: Fail<String, CombineError>  = Fail<String, CombineError>(error: CombineError.failed)
//fail.sink { completion in
//   switch completion {
//   case .finished:
//       print("Success")
//   case .failure(let someError):
//       print("Errror :\(someError)")
//   }
//} receiveValue: { value in
//   print("Empty: \(value)")
//}.store(in: &store)


