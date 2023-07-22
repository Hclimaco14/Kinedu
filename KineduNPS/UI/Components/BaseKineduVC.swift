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
    self.navigationController?.navigationBar.backgroundColor =  KineduColors.niceBlue
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
      guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
    loadingView.frame = CGRect.init(x: keyWindow.bounds.origin.x, y: keyWindow.bounds.origin.y, width: keyWindow.bounds.size.width, height: keyWindow.bounds.size.height)
    keyWindow.rootViewController?.view.isUserInteractionEnabled = false
    
      if UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.viewWithTag(500) == nil {
      UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
        keyWindow.addSubview(loadingView)
      }, completion: nil)
    }
  }
  
  func hideLoading() {
      if let viewWithTag = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.viewWithTag(500) {
          UIApplication.shared.windows.first?.rootViewController?.view.isUserInteractionEnabled = true
          UIView.transition(with: self.view, duration: 0.5, options: [.transitionCrossDissolve], animations: {
              viewWithTag.removeFromSuperview()
          }, completion: nil)
      }
  }
  
  func showAlert(title:String,body:String,style: UIAlertController.Style = .alert,_ completion: (()->Void)? = nil) {
    let alert = UIAlertController(title: title, message: body, preferredStyle: style)
    let action = UIAlertAction(title: "ALERT_ACTION_TEXT".localized(), style: .default) { (action) in
      completion?()
    }
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
  
}
