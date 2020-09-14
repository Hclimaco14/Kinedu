//
//  ScoreView.swift
//  KineduNPS
//
//  Created by Hector Climaco on 12/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class ScoreView: UIView {
  
  static let nibName = "ScoreView"
  
  //MARK: Outlets
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var typeUserLbl: UILabel!
  @IBOutlet weak var scoreLbl: UILabel!
  @IBOutlet weak var totalUserLbl: UILabel!
  
  
  //MARK: inputData
  var userScore = UserScoreItem(typeUser: "freemium", score: 0, totalUser: 0) {
    didSet {
      let isPremium = userScore.typeUser.lowercased().contains("premium") ? true : false
      setType(isPremiun: isPremium)
      setScore(score: userScore.score)
      setTotalUser(totalUser: userScore.totalUser)
    }
  }
  
  //MARK: Constants
  private let scoreGreen = 70
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    Bundle.main.loadNibNamed(ScoreView.nibName, owner: self, options: nil)
    addSubview(contentView)
    contentView.layer.masksToBounds = true
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    setStyle()
  }
  
  func configure(_ view:UIView) {
    self.frame.size = view.frame.size
  }
  
  func setStyle() {
    typeUserLbl.font = KineduFonts.NPSGothamMedium17
    typeUserLbl.textColor = KineduColors.niceBlue
    
    scoreLbl.font = KineduFonts.NPSGothamBold80
    scoreLbl.minimumScaleFactor = 0.3
    scoreLbl.textColor = KineduColors.red
    
    totalUserLbl.font = KineduFonts.NPSGothamBook16
    
  }
  
  
  
  func setType(isPremiun: Bool) {
    if isPremiun {
      typeUserLbl.text = "PREMIUM_USERS".localized()
    } else {
      typeUserLbl.text = "FREMIUM_USERS".localized()
    }
    
  }
  
  func setScore(score:Int) {
    scoreLbl.text = "\(score)"
    if score < scoreGreen {
      scoreLbl.textColor = KineduColors.red
    } else {
      scoreLbl.textColor = KineduColors.green
    }
  }
  
  func setTotalUser(totalUser:Int) {
    let totalUserStr = "TOTAL_USER".localized().replacingOccurrences(of: "NUMBER_USER", with: "\(totalUser)")
    totalUserLbl.text =  totalUserStr
  }
  
}
