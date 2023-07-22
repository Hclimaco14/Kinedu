//
//  UserScoreItem.swift
//  KineduNPS
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

public struct UserScoreItem: Codable {
  var typeUser:String
  var score:Int
  var totalUser:Int
  
  init(typeUser:String, score:Int, totalUser:Int) {
    self.typeUser = typeUser
    self.score = score
    self.totalUser = totalUser
  }
  
    var description: String{
    var desc = "\ntypeUser: \(String(describing: typeUser))"
    desc += "\nscore: \(String(describing: score))"
    desc += "\ntotalUser: \(String(describing: totalUser))"
    
    return desc
  }
}
