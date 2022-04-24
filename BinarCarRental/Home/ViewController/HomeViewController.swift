//
//  HomeViewController.swift
//  BinarCarRental
//
//  Created by Nugi Nuryanto G on 14/04/22.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var homeTableView: UITableView!

  var car = initCar
  
  override func viewDidLoad() {
    super.viewDidLoad()
    homeTableView.delegate = self
    homeTableView.dataSource = self

    homeTableView.register(BannerTableViewCell.nib(), forCellReuseIdentifier: "BannerTableViewCell")
    homeTableView.register(MenuTableViewCell.nib(), forCellReuseIdentifier: "MenuTableViewCell")
    homeTableView.register(TitleListTableViewCell.nib(), forCellReuseIdentifier: "TitleListTableViewCell")
    homeTableView.register(CarListsTableViewCell.nib(), forCellReuseIdentifier: "CarListsTableViewCell")
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    car.data.count + 3
  }

//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    if indexPath.row == 1 {
//      return 110.0
//    }
//    return UITableView.automaticDimension
//  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell: BannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell
      cell.selectionStyle = .none
      return cell

    case 1:
      let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
      cell.selectionStyle = .none
      return cell

    case 2:
      let cell: TitleListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TitleListTableViewCell", for: indexPath) as! TitleListTableViewCell
      cell.selectionStyle = .none
      return cell

    default:
      let cell: CarListsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CarListsTableViewCell", for: indexPath) as! CarListsTableViewCell
      cell.selectionStyle = .none
      cell.item = car.data[indexPath.row - 3]
      cell.tapHandler = {
        let vc = DetailViewController(dataCar: self.car.data[indexPath.row - 3], delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
      }
      return cell
    }
  }
}

extension HomeViewController: DetailViewControllerDelegate {
  func updateFavorite(_ carData: CarData) {
    if let index = car.data.firstIndex(where: { $0.name == carData.name }) {
      car.data[index] = carData
    }
    homeTableView.reloadData()
  }
}
