//
//  CarListModel.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 05/05/22.
//

struct CarData: Codable {
  var id: Int?
  var name, category: String?
  var price: Int?
  var status: Bool?
  var startRentAt: String?
  var finishRentAt: String?
  var image: String?
  var createdAt: String?
  var updatedAt: String?

  enum CodingKeys: String, CodingKey {
    case id, name, category, price, status
    case startRentAt = "start_rent_at"
    case finishRentAt = "finish_rent_at"
    case image, createdAt, updatedAt
  }
}

typealias CarResponse = [CarData]
