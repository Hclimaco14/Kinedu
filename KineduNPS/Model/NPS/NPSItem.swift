//
//  NPSItem.swift
//  KineduNPS
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation
import ObjectMapper

open class NPSItem: NSObject,Mappable {
  var id:Int?
  var nps:Int?
  var days_since_signup:Int?
  var user_plan: String?
  var activity_views:Int?
  var build:BuildItem?
  
  open override var description: String {
    
    var desc = "id: \(String(describing:  id))"
    desc += "\nnps: \(String(describing:  nps))"
    desc += "\ndays_since_signup: \(String(describing:  days_since_signup))"
    desc += "\nuser_plan: \(String(describing:  user_plan))"
    desc += "\nactivity_views: \(String(describing:  activity_views))"
    desc += "\nbuild: \(String(describing:  build))"
    
    return desc
  }
  
  
  public override init() {}
  
  required public init?(map: Map) {
  }
  
  open func mapping(map: Map) {
    id <- map["id"]
    nps <- map["nps"]
    days_since_signup <- map["days_since_signup"]
    user_plan <- map["user_plan"]
    activity_views <- map["activity_views"]
    build <- map["build"]
  }
}
