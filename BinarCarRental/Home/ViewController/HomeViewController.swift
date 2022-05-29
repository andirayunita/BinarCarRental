//
//  HomeViewController.swift
//  BinarCarRental
//
//  Created by Nugi Nuryanto G on 14/04/22.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var homeTableView: UITableView!

  private enum SectionType {
    case banner, menuTable, carLists
  }

  private let sections: [SectionType] = [.banner, .menuTable, .carLists]

  var carsData: [CarData]? {
    didSet {
      homeTableView.reloadData()
    }
  }

  var index: Int?

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
          self.carsData = result
          self.homeTableView.reloadData()
        }
      } catch {
        print("Fetch failed: \(error.localizedDescription)")
      }
    }.resume()
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let sectionView = HeaderView(frame: CGRect(x: 0, y: 0, width: homeTableView.frame.size.width, height: 37))
    switch sections[section] {
    case .carLists:
      sectionView.title = "Daftar Mobil Pilihan"
    default:
      sectionView.title = ""
    }
    return sectionView
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch sections[section] {
    case .carLists:
      return 37
    default:
      return 0.0001
    }
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    0.0001
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch sections[section] {
    case .carLists:
      return carsData?.count ?? 0
    default:
      return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch sections[indexPath.section] {
    case .banner:
      let cell: BannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell
      cell.delegate = self
      cell.selectionStyle = .none
      return cell

    case .menuTable:
      let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
      cell.selectionStyle = .none
      return cell

    case .carLists:
      let cell: CarListsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CarListsTableViewCell", for: indexPath) as! CarListsTableViewCell
      cell.selectionStyle = .none
      let indexCar = carsData?[indexPath.row]
      cell.item = (indexCar?.name ?? "", indexCar?.price ?? 0)
      cell.tapHandler = {
        let vc = DetailViewController(dataCar: self.carsData![indexPath.row], delegate: self)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
      }
      return cell
    }
  }
}

extension HomeViewController: AddCarDelegate, AddViewControllerDelegate, DetailViewControllerDelegate {
  func deleteDelegate(car: CarData, index: Int?) {
    self.carsData?.remove(at: index ?? 0)
    self.homeTableView.reloadData()
    self.navigationController?.popToRootViewController(animated: true)
  }

  func updateData(car: CarData) {
    self.carsData?[index ?? 0].name = car.name
    self.carsData?[index ?? 0].price = car.price
    self.homeTableView.reloadData()
  }

  func updateFavorite(_ dataCar: CarData) {
    if let index = carsData?.firstIndex(where: { $0.name == dataCar.name }) {
      carsData![index] = dataCar
    }
    homeTableView.reloadData()
  }

  func addData(cars: CarData) {
    self.carsData?.append(cars)
    self.homeTableView.reloadData()
  }

  func tapAdd() {
    let vc = AddViewController()
    vc.delegate = self
    self.present(vc, animated: true, completion: nil)
  }
}
