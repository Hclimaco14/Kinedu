//
//  AppCoordinator.swift
//  KineduNPS
//
//  Created by Hector Climaco on 11/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//


import UIKit

class AppCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
  
  var navigationController: UINavigationController
  var childCoordinators = [Coordinator]()
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let vc = NPSHome(coordinator: self)
    vc.modalTransitionStyle = .crossDissolve
    navigationController.pushViewController(vc, animated: true)
  }
  
  
  func goToNPSDetail(version:String, npsItems: [NPSItem]) {
    let vc = NPSDetail(coordinator: self,version: version, npsItems: npsItems)
    navigationController.pushViewController(vc, animated: true)
  }
  
}
