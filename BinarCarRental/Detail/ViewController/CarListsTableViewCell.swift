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
  @IBOutlet weak var starIcon: UIImageView!

  var tapHandler: (() -> Void)?
  var item: CarData? {
    didSet {
      if let item = item {
        setupItem(carData: item)
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

  func setupItem(carData: CarData) {
    carNameLabel.text = carData.name
    priceLabel.text = carData.price.currencyFormat()
    starIcon.image = carData.isFavorite ? UIImage(named: "ic_star_fill") : UIImage(named: "ic_star")
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  class func nib() -> UINib { UINib(nibName: "CarListsTableViewCell", bundle: nil) }
    
}
