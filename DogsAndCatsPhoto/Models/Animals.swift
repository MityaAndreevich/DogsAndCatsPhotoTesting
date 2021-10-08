//
//  Animals.swift
//  CryptoCurrencyRateApp
//
//  Created by Dmitry Logachev on 27.09.2021.
//

struct Dogs: Decodable {
    let message: String?
    let status: String?
}

struct Cats: Codable {
    let url: String?
}
