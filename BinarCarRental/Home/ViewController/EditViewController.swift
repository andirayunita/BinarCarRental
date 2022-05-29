//
//  EditViewController.swift
//  BinarCarRental
//
//  Created by Andira Yunita on 07/05/22.
//

import UIKit

protocol EditViewControllerDelegate {
  func editData(cars: CarData)
}

class EditViewController: UIViewController {
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var submitButton: UIButton!

  var id: Int?
  var delegate: EditViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    submitButton.isEnabled = false
    nameTextField.addTarget(self, action: #selector(isNotEmpty), for: .editingChanged)
    priceTextField.addTarget(self, action: #selector(isNotEmpty), for: .editingChanged)
  }

  @objc func isNotEmpty(sender: UITextField) {
    guard let name = nameTextField.text, let price = priceTextField.text,
    name != "", price != "" else {
      self.submitButton.isEnabled = false
      return
    }
    submitButton.isEnabled = true
  }

  @IBAction func submitTapped(_ sender: UIButton) {
    guard let url = URL(string: "https://rent-car-appx.herokuapp.com/admin/car/\(id!)") else {
      print("Invalid URL")
      return
    }

    let body: [String: Any] = [
      "name": "\(nameTextField.text ?? "")",
      "price": Int(priceTextField.text ?? "") ?? 0
    ]

    var req = URLRequest(url: url)
    req.httpMethod = "PUT"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.allHTTPHeaderFields = [
      "Content-Type": "application/json",
      "Accept": "application/json"
    ]
    req.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

    URLSession.shared.dataTask(with: req) { data, response, error in
      if let result = try? JSONDecoder().decode(CarData.self, from: data!) {
        DispatchQueue.main.async {
          self.dismiss(animated: true) {
            self.delegate?.editData(cars: result)
          }
        }
      } else {
        print("\(error?.localizedDescription ?? "Unknown Error")")
      }    }.resume()
  }
}

