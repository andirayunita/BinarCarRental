//
//  CarListsTableViewCell.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 17/04/22.
//

import UIKit

class CarListsTableViewCell: UITableViewCell {

  @IBOutlet weak var carList: UIView!
  @IBOutlet weak var carNameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  var tapHandler: (() -> Void)?
  var item: (String, Int)? {
    didSet {
      if let item = item {
        setupItem(item)
      }
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupview()
  }

  func setupview() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(tapView))
    carList.addGestureRecognizer(tap)
    carList.addShadow()
  }

  @objc func tapView() {
    tapHandler?()
  }

  func setupItem(_ item: (String, Int)) {
    carNameLabel.text = item.0
    priceLabel.text = String(item.1.currencyFormat())
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  class func nib() -> UINib { UINib(nibName: "CarListsTableViewCell", bundle: nil) }

}
