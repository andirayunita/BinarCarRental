//
//  Int.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 24/04/22.
//

import Foundation

extension Int {
  func currencyFormat() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    return "Rp \(formatter.string(from: NSNumber(value: self)) ?? "")"
  }
}
