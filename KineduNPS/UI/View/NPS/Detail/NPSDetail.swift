//
//  NPSDetail.swift
//  KineduNPS
//
//  Created by Hector Climaco on 11/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class NPSDetail: BaseKineduVC {

  //MARK: Outlets
  @IBOutlet weak var npsSelectionView: UIView!
  @IBOutlet weak var npsChoiseSelectLbl: UILabel!
  @IBOutlet weak var npsSelectCV: UICollectionView!
  
  @IBOutlet weak var npsDetailsView: UIView!
  @IBOutlet weak var npsDetailViewTilteLbl: UILabel!
  
  
  @IBOutlet weak var fremiumScoreLbl: UILabel!
  @IBOutlet weak var fremiumLbl: UILabel!
  
  @IBOutlet weak var premiumScoreLbl: UILabel!
  @IBOutlet weak var premiumLbl: UILabel!
  
  
  @IBOutlet weak var percentageModeActivityView: UIView!
  @IBOutlet weak var percentageModeActivityLbl: UILabel!
  
  //MARK: internal variables
  private var coordinator:AppCoordinator?
  private let detailVM: NPSDetailsViewModel
  
  init(coordinator: AppCoordinator, version:String, npsItems: [NPSItem]) {
    self.coordinator = coordinator
    self.detailVM = NPSDetailsViewModel(version: version, npsItems: npsItems)
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setStyles()
    setContent()
    bindings()
  }
  
  func setContent() {
    self.title = detailVM.title
    self.npsChoiseSelectLbl.text = detailVM.choiseSelect
    
    self.npsDetailViewTilteLbl.text = detailVM.detailTitleView
    
    self.fremiumScoreLbl.text = detailVM.fremiumScore
    self.fremiumLbl.text = detailVM.fremiumLbl
    
    self.premiumScoreLbl.text = detailVM.premiumScore
    self.premiumLbl.text = detailVM.premiumLbl
    
    self.percentageModeActivityLbl.text = detailVM.percentageModeActivity
    
    npsSelectCV.dataSource = self
    npsSelectCV.delegate = self
  }
  
  func setStyles() {
    
    npsSelectCV.register(UINib(nibName: NPSChoiseCell.identifier, bundle: KineduConstants.bundle),
                         forCellWithReuseIdentifier: NPSChoiseCell.identifier)
    
    npsSelectionView.backgroundColor = KineduColors.niceBlue
    
    npsChoiseSelectLbl.textColor = KineduColors.white
    npsChoiseSelectLbl.font = KineduFonts.NPSGothamBold19
    
    npsDetailsView.clipsToBounds = true
    npsDetailsView.layer.borderColor = UIColor.red.cgColor
    npsDetailsView.layer.cornerRadius = KineduConstants.coornerRadius
    npsDetailsView.layer.shadowColor = KineduColors.brownGrey.cgColor
    npsDetailsView.layer.shadowOpacity = 2
    npsDetailsView.layer.shadowOffset = .zero
    npsDetailsView.layer.shadowRadius = 5
    
    npsDetailViewTilteLbl.textColor = KineduColors.brownGrey
    
    fremiumScoreLbl.textColor = KineduColors.darkSkyBlue
    fremiumScoreLbl.font = KineduFonts.NPSGothamBold36
    
    fremiumLbl.textColor = KineduColors.niceBlue
    fremiumLbl.font = KineduFonts.NPSGothamBook16
    
    premiumScoreLbl.textColor = KineduColors.darkSkyBlue
    premiumScoreLbl.font = KineduFonts.NPSGothamBold36
    
    premiumLbl.textColor = KineduColors.niceBlue
    premiumLbl.font = KineduFonts.NPSGothamBook16
    
    percentageModeActivityView.backgroundColor = KineduColors.niceBlue
    percentageModeActivityLbl.textColor = KineduColors.white
  }
  
  func bindings() {
    detailVM.refreshPremium = {
      self.premiumScoreLbl.text = self.detailVM.premiumScore
    }
    
    detailVM.refreshFreemium = {
      self.fremiumScoreLbl.text = self.detailVM.fremiumScore
    }
    
    detailVM.refreshPercentageMode = {
      self.percentageModeActivityLbl.text = self.detailVM.percentageModeActivity
    }
  }
}

extension NPSDetail: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return detailVM.arrayNPSChoice.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if let cell:NPSChoiseCell = npsSelectCV.dequeueReusableCell(withReuseIdentifier: NPSChoiseCell.identifier, for: indexPath) as? NPSChoiseCell {
      
      let index = detailVM.arrayNPSChoice[indexPath.row]
      cell.npsChoiseImgView.image = UIImage(named: "baby_\(index)")
      cell.npsChoiseLbl.text = "\(index)"
      
      return cell
    }
    
    return UICollectionViewCell()
  }
  
  
}
extension NPSDetail: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    
    detailVM.loadDataByAsnwer(detailVM.arrayNPSChoice[indexPath.row])
  }
}
extension NPSDetail: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let widthCell = npsSelectCV.bounds.size.width / CGFloat(KineduConstants.numCellView)
    let heightCell = npsSelectCV.bounds.size.height
    

    return CGSize(width: widthCell, height: heightCell)
      
  }
}
