//
//  HomeViewController.swift
//  BinarCarRental
//
//  Created by Nugi Nuryanto G on 14/04/22.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var homeTableView: UITableView!

  var car = [CarData]()
  var index: Int?

//  private enum sectionType {
//    case banner, menuTable, carLists
//  }
//
//  private let sections: [sectionType] = [.banner, .menuTable, .carLists]
//
//  var carLists: [CarData]? {
//    didSet {
//      homeTableView.reloadData()
//    }
//  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    homeTableView.delegate = self
    homeTableView.dataSource = self

    homeTableView.register(BannerTableViewCell.nib(), forCellReuseIdentifier: "BannerTableViewCell")
    homeTableView.register(MenuTableViewCell.nib(), forCellReuseIdentifier: "MenuTableViewCell")
    homeTableView.register(TitleListTableViewCell.nib(), forCellReuseIdentifier: "TitleListTableViewCell")
    homeTableView.register(CarListsTableViewCell.nib(), forCellReuseIdentifier: "CarListsTableViewCell")

    getCarAPI()

//    homeTableView.register(cellType: BannerTableViewCell.self)
//    homeTableView.register(cellType: MenuTableViewCell.self)
//    homeTableView.register(cellType: TitleListTableViewCell.self)
//    homeTableView.register(cellType: CarListsTableViewCell.self)
  }

  func getCarAPI() {
    guard let url = URL(string: "https://rent-car-appx.herokuapp.com/admin/car") else {
      print("Invalid URL")
      return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
      do {
        let result = try JSONDecoder().decode([CarData].self, from: data!)
        DispatchQueue.main.async {
          self.car = result
          self.homeTableView.reloadData()
        }
      } catch {
        print("Fetch failed: \(error.localizedDescription)")
      }
    }.resume()
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    car.count + 3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell: BannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell
      cell.delegate = self
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
      let indexCar = car[indexPath.row - 3]
      cell.item = (indexCar.name ?? "", indexCar.price ?? 0)
      cell.tapHandler = {
        let vc = DetailViewController(dataCar: (indexCar.name ?? "", indexCar.price ?? 0, indexCar.id!), delegate: self)
        self.index = indexPath.row - 3
        vc.delegate = self
        vc.index = self.index!
        self.navigationController?.pushViewController(vc, animated: true)
      }
      return cell
    }
  }
}

extension HomeViewController: AddCarDelegate, AddViewControllerDelegate, DetailViewControllerDelegate {
  func deleteDelegate(car: CarData, index: Int?) {
    self.car.remove(at: index!)
    self.homeTableView.reloadData()
    self.navigationController?.popToRootViewController(animated: true)
  }

  func updateData(car: CarData) {
    self.car[index!].name = car.name
    self.car[index!].price = car.price
    self.homeTableView.reloadData()
  }

  func updateFavorite(_ dataCar: CarData) {
    if let index = car.firstIndex(where: { $0.name == dataCar.name }) {
      car[index] = dataCar
    }
    homeTableView.reloadData()
  }

  func addData(cars: CarData) {
    self.car.append(cars)
    self.homeTableView.reloadData()
  }

  func tapAdd() {
    let vc = AddViewController()
    vc.delegate = self
    self.present(vc, animated: true, completion: nil)
  }
}


//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    switch sections[section] {
//    case .carLists:
//      return carLists?.count ?? 0
//    case .banner, .menuTable:
//      return 1
//    }
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    switch sections[indexPath.section] {
//    case .banner:
//      let cell: BannerTableViewCell = tableView.dequeueReusableCell(for: indexPath)
//      cell.banner =
//      return cell
//    case .menuTable:
//      let cell: MenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
//      cell.menu =
//      return cell
//    case .carLists:
//      let cell: CarListsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
//      cell.carLists =
//      return cell
//    }
//  }
//}
