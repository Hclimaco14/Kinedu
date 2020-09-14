//
//  NPSDetailsViewModel.swift
//  KineduNPS
//
//  Created by Hector Climaco on 14/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation

class NPSDetailsViewModel: NSObject {
  var title:String
  var choiseSelect:String
  var detailTitleView:String
  var fremiumLbl:String
  var premiumLbl:String
  var arrayNPSChoice:[Int]
  
  var refreshFreemium:(()->Void)?
  var refreshPremium:(()->Void)?
  var refreshPercentageMode:(()->Void)?
  
  private var npsItems:[NPSItem]
  var fremiumScore = "00" {
    didSet {
      refreshFreemium?()
    }
  }
  
  var premiumScore = "00" {
    didSet {
      refreshPremium?()
    }
  }
  
  var percentageModeActivity = "NO_USERS".localized() {
    didSet {
      refreshPercentageMode?()
    }
  }
  
  init(version:String = "1.1",npsItems:[NPSItem] = []) {
    self.npsItems = npsItems
    
    self.title = ("DETAIL_TITLE".localized() + version)
    
    self.choiseSelect = "CHOISE_SELECT".localized()
    self.detailTitleView = "DETAIL_TITLE_VIEW".localized()
    
    self.fremiumLbl = "FREMIUM_LABEL".localized()
    self.premiumLbl = "PREMIUM_LABEL".localized()
    
    self.arrayNPSChoice = [0,1,2,3,4,5,6,7,8,9,10]
  }
  
  func loadDataByAsnwer(_ answer:Int) {
    let npsByAnswer = npsItems.filter{ ($0.nps == answer) }
    loadUserbyType(by: npsByAnswer)
    loadPercentUser(by: npsByAnswer, answer: answer)
  }
  
  private func loadUserbyType(by npsByAnswer: [NPSItem] ) {
    let npsPremium =  npsByAnswer.filter{ ($0.user_plan?.lowercased().contains("premium") ?? false)}
    premiumScore = String(format: "%02d", npsPremium.count)
    let npsFreemium =  npsByAnswer.filter{ ($0.user_plan?.lowercased().contains("freemium") ?? false)}
    fremiumScore = String(format: "%02d", npsFreemium.count)
  }
  
  private func loadPercentUser(by npsByAnswer: [NPSItem],answer:Int) {
    if npsByAnswer.count <= 0 {
      percentageModeActivity = "NO_USERS".localized()
      return
    }
    let gropActivitiesView =  Dictionary(grouping: npsByAnswer, by: { ($0.activity_views) })
    
    percent(grpups: gropActivitiesView,answer: answer)
   
  }
  
  func percent(grpups: [Int? : [NPSItem]],answer:Int) {
    var total = 0
    var maxUserByGroup = 0
    var key = 0
    for groupByView in grpups {
      if groupByView.value.count > maxUserByGroup {
        maxUserByGroup = groupByView.value.count
        key = groupByView.key ?? 0
      }
      
      total += groupByView.value.count
    }
    let percent = Int((Float(maxUserByGroup) / Float(total)) * 100)
    
    var desc = "PERCENT_USER".localized().replacingOccurrences(of: "PERCENT_USER", with: "\(percent)")
    desc = desc.replacingOccurrences(of: "ANSWER_KEY", with: "\(answer)")
    desc = desc.replacingOccurrences(of: "ACTIVITIES_KEY", with: "\(key)")
    
    percentageModeActivity = desc
  }
  
 
}
