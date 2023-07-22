//
//  NPSHomeViewModel.swift
//  KineduNPS
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import Foundation


class NPSHomeViewModel: NSObject {
  
  let services = NPSServices()
  
  var title:String
  var subtitle:String
  
  var refreshVersion:(()->Void)?
  var refreshFreemium:(()->Void)?
  var refreshPremium:(()->Void)?
  
  var errorService:((String)->Void)?

  var versions: Dictionary<String,[NPSItem]> = [:] {
    didSet {
      refreshVersion?()
    }
  }
  
  var freemiumUser = UserScoreItem(typeUser: "Freemium", score: 0, totalUser: 0) {
    didSet {
      refreshFreemium?()
    }
  }
  
  var premiumUser = UserScoreItem(typeUser: "Premium", score: 0, totalUser: 0) {
    didSet{
      refreshPremium?()
    }
  }
  
  override init() {
    self.title = "NPS_SCORE_TITLE".localized()
    self.subtitle = "NPS_SCORE_SUBTITLE".localized()
  }
  
  public func loadData() {
    self.versions.removeAll()
    services.getNPS(loadFromFile: true) { result in
        
        switch result {
        case .success(let responseItems):
            guard let items = responseItems else  { return }
            self.versions = Dictionary(grouping: items, by: { ($0.build?.version ?? "1.1") })
        case .failure(let failure):
            self.errorService?(failure.description)
        }
    }
  }
  
  public func loadDatabyVersion(version: String) {
     guard let npsByVersion = versions[version] else { return }
    classifyUSer(groupVersion: npsByVersion)
  }
  
  private func classifyUSer(groupVersion: [NPSItem]) {
    
    let npsPremium =  groupVersion.filter{ ($0.user_plan?.lowercased().contains("premium") ?? false)}
    premiumUser = UserScoreItem(typeUser: "premium", score: npsScore(npsByVersions: npsPremium), totalUser: npsPremium.count)
    
    let npsFreemium =  groupVersion.filter{ ($0.user_plan?.lowercased().contains("freemium") ?? false)}
    freemiumUser = UserScoreItem(typeUser: "freemium", score: npsScore(npsByVersions: npsFreemium), totalUser: npsFreemium.count)
  }
  
  private func npsScore(npsByVersions: [NPSItem]) -> Int {
    var promoters = [NPSItem]()
    var detractors = [NPSItem]()
    
    for npsItem in npsByVersions {
      guard let nps = npsItem.nps else { continue }
      if nps >= 9{
        promoters.append(npsItem)
      } else if nps <= 6 {
        detractors.append(npsItem)
      }
    }
    if promoters.count > 0  || detractors.count > 0{
      let percent = Float(promoters.count - detractors.count) / Float(npsByVersions.count)
      return Int(percent * 100)
    }
    
    return 0
  }
  
}
