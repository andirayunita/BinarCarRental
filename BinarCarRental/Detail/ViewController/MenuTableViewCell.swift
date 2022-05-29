//
//  MenuTableViewCell.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 18/04/22.
//

import UIKit

enum Menu {
  case rentalCar
  case hostelry
  case souvenir
  case tour
}

class MenuTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  @IBOutlet weak var menuCollectionView: UICollectionView!

  var menus: [Menu] = [
    .rentalCar,
    .hostelry,
    .souvenir,
    .tour
  ]

  override func awakeFromNib() {
    super.awakeFromNib()
    menuCollectionView.delegate = self
    menuCollectionView.dataSource = self

    menuCollectionView.register(MenuCollectionViewCell.nib(), forCellWithReuseIdentifier: "MenuCollectionViewCell")
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    menus.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: MenuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
    cell.menu = menus[indexPath.row]
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.size.width - 30)/4
    let height = 95/86 * width
    return CGSize(width: width, height: height)
  }

  class func nib() -> UINib { UINib(nibName: "MenuTableViewCell", bundle: nil) }
    
}
