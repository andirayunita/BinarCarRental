//
//  DetailViewController.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 16/04/22.
//

import UIKit

protocol DetailViewControllerDelegate {
  func updateFavorite(_ dataCar: CarData)
  func deleteDelegate(car: CarData, index: Int?)
  func updateData(car: CarData)
}

class DetailViewController: UIViewController {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var aboutPackage: UIView!
  @IBOutlet weak var includePackageLabel: UILabel!
  @IBOutlet weak var excludePackageLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  var dataCar: CarData
  var delegate: DetailViewControllerDelegate?
  var index: Int?

  init(dataCar: CarData, delegate: DetailViewControllerDelegate) {
    self.dataCar = dataCar
    self.delegate = delegate
    super.init(nibName: "DetailViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.backgroundColor = .clear
    let backButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(backAction))
    navigationItem.leftBarButtonItem = backButton
  }

  @objc func backAction() {
    navigationController?.popViewController(animated: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    aboutPackage.addShadow()
    includePackageLabel.addToBulletedList()
    excludePackageLabel.addToBulletedList()
    loadCarData()
  }

  func loadCarData() {
    nameLabel.text = dataCar.name
    priceLabel.text = dataCar.price?.currencyFormat()
  }

  @IBAction func editTapped(_ sender: UIButton) {
    let vc = EditViewController()
    vc.id = dataCar.id
    vc.delegate = self
    self.present(vc, animated: true, completion: nil)
  }

  @IBAction func deleteTapped(_ sender: UIButton) {
    guard let url = URL(string: "https://rent-car-appx.herokuapp.com/admin/car/\(dataCar.id ?? 0)") else {
      print("Invalid URL")
      return
    }
    var req = URLRequest(url: url)
    req.httpMethod = "DELETE"
    URLSession.shared.dataTask(with: req) { data, response, error in
      do {
        let result = try JSONDecoder().decode(CarData.self, from: data!)
        DispatchQueue.main.async { self.delegate?.deleteDelegate(car: result, index: self.index) }
      } catch {
        print(error.localizedDescription)
      }
    }.resume()
    print("\(dataCar.id ?? 0)")
  }
}

extension DetailViewController: EditViewControllerDelegate {
  func editData(cars: CarData) {
    self.priceLabel.text = "\(cars.price ?? 0)"
    self.nameLabel.text = cars.name
    self.delegate?.updateData(car: cars)
    self.navigationController?.popToRootViewController(animated: true)
  }
}
