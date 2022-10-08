//
//  Car.swift
//  Carlist
//
//  Created by Erkhaan  on 07.10.2022.
//

import Foundation

struct Car: Codable {
    var year: Int
    var brand: String
    var model: String
    var type: String
}

let unitToyota = Car(
    year: 1986,
    brand: "Toyota",
    model: "AE86",
    type: "Coupe")

let unitBMW = Car(
    year: 1992,
    brand: "BMW",
    model: "E30",
    type: "Sedan")

let unitSuzuki = Car(
    year: 1998,
    brand: "Suzuki",
    model: "Esteem",
    type: "Sedan")

var carList = [
    unitToyota,
    unitBMW,
    unitSuzuki]
