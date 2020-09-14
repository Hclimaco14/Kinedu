//
//  Coordinator.swift
//  KineduNPS
//
//  Created by Hector Climaco on 11/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//


import UIKit

protocol Coordinator:AnyObject {
  var navigationController:UINavigationController { get set }
  var childCoordinators:[Coordinator] { get set }
  func start()
}

