//
//  BuildItem.swift
//  KineduNPS
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

public struct BuildItem: Codable {
  var release_date:String?
  var version:String?
  
    var description: String {
    var desc = "release_date: \( String(describing:  release_date))"
    desc += "\nversion: \(String(describing: version))"
    
    return desc
  }
  
}
