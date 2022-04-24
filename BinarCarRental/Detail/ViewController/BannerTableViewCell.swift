//
//  BannerTableViewCell.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 17/04/22.
//

import UIKit

class BannerTableViewCell: UITableViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  class func nib() -> UINib { UINib(nibName: "BannerTableViewCell", bundle: nil) }
  
}
