//
//  AppDelegate.swift
//  MoviesDB
//
//  Created by Mahmoud Abolfotoh on 2/22/19.
//  Copyright © 2019 Mahmoud Abolfotoh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let moviesController = MoviesController()
        let navigationController = UINavigationController(rootViewController: moviesController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        if CommandLine.arguments.contains("enable-testing") {
            UIView.setAnimationsEnabled(false)
        }
        return true
    }
}

