//
//  UILabel.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 18/04/22.
//

import Foundation
import UIKit

extension UILabel {
  func addToBulletedList() {
    if let string = self.text {
      var updatedText: String
      if string.contains("\n\n") {
        updatedText = string.replacingOccurrences(of: "\n\n", with: "\n• ")
      } else {
        let regex = try! NSRegularExpression(pattern: "(?<=[\\.!])[\\s]+(?=[A-Z])")
        updatedText = regex.stringByReplacingMatches(in: string, options: [], range: NSRange(location: 0, length: string.count), withTemplate: "\n• " )
      }

      updatedText = "• \(updatedText)"

      let formattedText = NSMutableAttributedString( string: updatedText)
      formattedText.addAttributes( [NSAttributedString.Key.paragraphStyle: createParagraphAttribute()], range: NSMakeRange(0, formattedText.length) )

      self.attributedText = formattedText
    }
  }

  private func createParagraphAttribute() -> NSParagraphStyle {
    let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
    paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 11, options: [:])]
    paragraphStyle.defaultTabInterval = 11
    paragraphStyle.firstLineHeadIndent = 0
    paragraphStyle.headIndent = 11
    paragraphStyle.paragraphSpacing = 10

    return paragraphStyle
  }
}
