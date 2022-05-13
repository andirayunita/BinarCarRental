//
//  AddViewController.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 24/04/22.
//

import UIKit

protocol AddViewControllerDelegate {
  func addData(cars: CarData)
}

class AddViewController: UIViewController {
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var btnSubmit: UIButton!

  var delegate: AddViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    nameTextField.placeholder = "Name"
    priceTextField.placeholder = "Price"

    btnSubmit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    btnSubmit.isEnabled = false
    nameTextField.addTarget(self, action: #selector(isNotEmpty), for: .editingChanged)
    priceTextField.addTarget(self, action: #selector(isNotEmpty), for: .editingChanged)
  }

  @objc func isNotEmpty(sender: UITextField) {
    guard let name = nameTextField.text, let price = priceTextField.text,
          name != "", price != "" else {
      self.btnSubmit.isEnabled = false
      return
    }
    btnSubmit.isEnabled = true
  }


  @IBAction func submitTapped(_ sender: UIButton) {
    guard let url = URL(string: "https://rent-car-appx.herokuapp.com/admin/car") else {
      print("Invalid URL")
      return
    }

    let body: [String: Any] = [
      "name": "\(nameTextField.text ?? "")",
      "price": Int(priceTextField.text ?? "") ?? 0
    ]

    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

    URLSession.shared.dataTask(with: req) { data, response, error in
      if let result = try? JSONDecoder().decode(CarData.self, from: data!) {
        DispatchQueue.main.async {
          self.dismiss(animated: true) {
            self.delegate?.addData(cars: result)
          }
        }
      } else {
        print("\(error?.localizedDescription ?? "Unknown Error")")
      }
    }.resume()
  }
}
