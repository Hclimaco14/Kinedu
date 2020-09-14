//
//  BuildItem.swift
//  KineduNPS
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation
import ObjectMapper

open class BuildItem: NSObject,Mappable {
  var release_date:String?
  var version:String?
  
  open override var description: String {
    var desc = "release_date: \( String(describing:  release_date))"
    desc += "\nversion: \(String(describing: version))"
    
    return desc
  }
  
  public override init() {}
  
  required public init?(map: Map) {
  }
  
  open func mapping(map: Map) {
    release_date <- map["release_date"]
    version <- map["version"]
    
  }
}
