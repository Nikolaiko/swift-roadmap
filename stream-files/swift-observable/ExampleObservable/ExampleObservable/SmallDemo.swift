//
//  SmallDemo.swift
//  ExampleObservable
//
//  Created by Nikolai Baklanov on 27.03.2024.
//

import Foundation

let cars = [BrandNewCar(name: "One", years: 4), BrandNewCar(name: "Two", years: 2)]

func test() {

    withObservationTracking {
        for car in cars {
            print(car.name)
        }
    } onChange: {
        print("Поставить перерисовку в очередь")
    }


    cars.first!.years += 1
}
