//
//  AppDelegate.swift
//  KineduNPS
//
//  Created by Hector Climaco on 11/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var appCoordinator:AppCoordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Thread.sleep(forTimeInterval: 0.5)
    let navController = UINavigationController()
    appCoordinator = AppCoordinator(navigationController: navController)
    appCoordinator?.start()
    window = UIWindow()
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    
    return true
  }
  
}

