//
//  TitleListTableViewCell.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 18/04/22.
//

import UIKit

class TitleListTableViewCell: UITableViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  class func nib() -> UINib { UINib(nibName: "TitleListTableViewCell", bundle: nil) }
  
}
