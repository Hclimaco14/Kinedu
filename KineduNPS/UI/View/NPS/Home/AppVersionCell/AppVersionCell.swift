//
//  AppVersionCell.swift
//  KineduNPS
//
//  Created by Hector Climaco on 13/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class AppVersionCell: UICollectionViewCell {
  static let identifier = "AppVersionCell"
  @IBOutlet weak var titleLbl: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = KineduColors.white
    configureCell()
  }
  
  override var isSelected: Bool {
    didSet {
      configureCell()
    }
  }
  
  func configureCell() {
    self.contentView.backgroundColor = isSelected ? KineduColors.areaColorLinguistic : KineduColors.white
    self.titleLbl.textColor = isSelected ? KineduColors.white : KineduColors.niceBlue
    if !isSelected {
      self.contentView.layer.borderColor = isSelected ? UIColor.clear.cgColor : UIColor.lightGray.cgColor
      self.contentView.layer.borderWidth = isSelected ? 0 : KineduConstants.borderwith
    }
  }
     

}
