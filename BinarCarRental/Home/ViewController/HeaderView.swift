//
//  HeaderView.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 13/05/22.
//

import UIKit

class HeaderView: UIView {
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!

  var title: String? {
    didSet {
      if let title = title {
        titleLabel.text = title
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  func commonInit() {
    Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
  }
}
