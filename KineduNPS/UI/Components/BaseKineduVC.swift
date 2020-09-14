//
//  BaseKineduVC.swift
//  KineduNPS
//
//  Created by Hector Climaco on 11/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class BaseKineduVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    
  }
  
  private func configureView() {
    self.navigationController?.navigationBar.barTintColor = KineduColors.niceBlue
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: KineduColors.white]
    createBackButton()
  }
  
  private func createBackButton() {
    let barButton = UIBarButtonItem(title: "",style: .plain,target: self,action: nil)
    navigationItem.backBarButtonItem = barButton
    navigationItem.backBarButtonItem?.tintColor = KineduColors.white
    
  }
  
  func showLoading() {
    self.view.endEditing(true)
    let loadingView = LoadingView()
    loadingView.tag = 500
    guard let keyWindow = UIApplication.shared.keyWindow else { return }
    loadingView.frame = CGRect.init(x: keyWindow.bounds.origin.x, y: keyWindow.bounds.origin.y, width: keyWindow.bounds.size.width, height: keyWindow.bounds.size.height)
    keyWindow.rootViewController?.view.isUserInteractionEnabled = false
    
    if UIApplication.shared.keyWindow?.viewWithTag(500) == nil {
      UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
        keyWindow.addSubview(loadingView)
      }, completion: nil)
    }
  }
  
  func hideLoading() {
      if let viewWithTag = UIApplication.shared.keyWindow?.viewWithTag(500) {
          UIApplication.shared.keyWindow?.rootViewController?.view.isUserInteractionEnabled = true
          UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
              viewWithTag.removeFromSuperview()
          }, completion: nil)
      }
  }
  
}
