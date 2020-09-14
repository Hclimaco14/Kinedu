//
//  StringExtensions.swift
//  KineduNPS
//
//  Created by Hector Climaco on 12/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

extension String {
  func localized() -> String{
    let localized = self
    let message = NSLocalizedString(localized, tableName: "KineduEng", bundle: KineduConstants.bundle , value: "", comment: "")
    if !message.isEmpty && message != localized{
      return message
    }else{
      return localized
    }
  }
}
