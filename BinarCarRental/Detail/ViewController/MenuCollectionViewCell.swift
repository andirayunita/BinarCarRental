//
//  MenuCollectionViewCell.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 18/04/22.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {

  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!

  var menu: Menu? {
    didSet {
      if let menu = menu {
        setupItem(menu: menu)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  func setupItem(menu: Menu) {
    switch menu {
    case .rentalCar:
      iconImage.image = .iconTruck
      titleLabel.text = "Sewa Mobil"
    case .souvenir:
      iconImage.image = .iconBox
      titleLabel.text = "Oleh-oleh"
    case .hostelry:
      iconImage.image = .iconKey
      titleLabel.text = "Penginapan"
    case .tour:
      iconImage.image = .iconCamera
      titleLabel.text = "Wisata"
    }
  }

  class func nib() -> UINib { UINib(nibName: "MenuCollectionViewCell", bundle: nil) }
}
