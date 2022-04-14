//
//  AppDelegate.swift
//  BinarCarRental
//
//  Created by Nugi Nuryanto G on 14/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let rootViewController = UINavigationController(rootViewController: HomeViewController())
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = rootViewController
    self.window?.makeKeyAndVisible()
    
    return true
  }
}

