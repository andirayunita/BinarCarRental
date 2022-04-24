//
//  DetailViewController.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 16/04/22.
//

import UIKit

protocol DetailViewControllerDelegate {
}

class DetailViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var aboutPackage: UIView!
  @IBOutlet weak var includePackageLabel: UILabel!
  @IBOutlet weak var excludePackageLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  var dataCar: CarData
  var delegate: DetailViewControllerDelegate

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
    priceLabel.text = dataCar.price.currencyFormat()
  }

  @IBAction func favoriteTapped(_ sender: UIButton) {
  }
}
