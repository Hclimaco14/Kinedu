//
//  NPSChoiseCell.swift
//  KineduNPS
//
//  Created by Hector Climaco on 14/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class NPSChoiseCell: UICollectionViewCell {
  
  static let identifier = "NPSChoiseCell"
  @IBOutlet weak var npsChoiseImgView: UIImageView!
  @IBOutlet weak var npsChoiseLbl: UILabel!
  
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCell()
  }
  
  func configureCell() {
    self.npsChoiseLbl.textColor = KineduColors.white
    self.npsChoiseLbl.font = KineduFonts.NPSGothamBold19
    self.npsChoiseLbl.minimumScaleFactor = 0.7
  }
  
}
