//
//  NPSHome.swift
//  KineduNPS
//
//  Created by Hector Climaco on 11/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class NPSHome: BaseKineduVC {
  
  //MARK: Outlets
  @IBOutlet weak var subtitleLbl: UILabel!
  @IBOutlet weak var appVersionCV: UICollectionView!
  
  @IBOutlet weak var npsScoreView: UIView!
  @IBOutlet weak var scoreViewTitleLbl: UILabel!
  
  @IBOutlet weak var freemiumScoreview: ScoreView!
  @IBOutlet weak var separatorScoreView: UIView!
  @IBOutlet weak var premiunScoreView: ScoreView!
  
  @IBOutlet weak var seeMoreDetailsBtn: UIButton!
  
  //MARK: internal variables
  private var homeVM = NPSHomeViewModel()
  private var coordinator:AppCoordinator?
  private var currentVersion = ""
  
  init(coordinator: AppCoordinator) {
    self.coordinator = coordinator
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    homeVM.loadData()
  }
  
  func configureView() {
    setStyles()
    setContent()
    bindings()
    self.seeMoreDetailsBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.seeMoreDetailsAction)))
  }
  
  
  func setContent() {
    self.title = homeVM.title
    self.subtitleLbl.text = homeVM.subtitle
    
    self.premiunScoreView.userScore = homeVM.premiumUser
    self.freemiumScoreview.userScore = homeVM.freemiumUser
    
    appVersionCV.delegate = self
    appVersionCV.dataSource = self
  }
  
  func setStyles() {
    appVersionCV.register( UINib(nibName: AppVersionCell.identifier, bundle: KineduConstants.bundle),
                          forCellWithReuseIdentifier: AppVersionCell.identifier)
    
    appVersionCV.layer.borderWidth = KineduConstants.borderwith
    appVersionCV.layer.borderColor = UIColor.lightGray.cgColor
    appVersionCV.layer.cornerRadius = KineduConstants.coornerRadius
    
    subtitleLbl.font = KineduFonts.NPSGothamBold19
    subtitleLbl.textColor = KineduColors.brownGrey
    
    npsScoreView.layer.cornerRadius = KineduConstants.coornerRadius
    npsScoreView.layer.shadowColor = KineduColors.brownGrey.cgColor
    npsScoreView.layer.shadowOpacity = 1
    npsScoreView.layer.shadowOffset = .zero
    npsScoreView.layer.shadowRadius = 2
    
    scoreViewTitleLbl.font = KineduFonts.NPSGothamBold19
    scoreViewTitleLbl.textColor = KineduColors.brownGrey
    
    seeMoreDetailsBtn.layer.cornerRadius = KineduConstants.coornerRadius
    seeMoreDetailsBtn.backgroundColor = KineduColors.green
    seeMoreDetailsBtn.titleLabel?.font =  KineduFonts.NPSGothamMedium17
    seeMoreDetailsBtn.setTitleColor(KineduColors.white, for: .normal)
    
  }
  
  func bindings() {
    homeVM.refreshVersion = {
      self.appVersionCV.reloadData()
      self.selectedFirstItem()
    }
    
    homeVM.refreshPremium = {
      self.premiunScoreView.userScore = self.homeVM.premiumUser
    }
    
    homeVM.refreshFreemium = {
      self.freemiumScoreview.userScore = self.homeVM.freemiumUser
    }
    homeVM.services.showLoading = {
      self.showLoading()
    }
    homeVM.services.hideLoading = {
      self.hideLoading()
    }
    
  }
  
  func selectedFirstItem() {
    guard homeVM.versions.count > 0 else {
      return
    }
    appVersionCV.isHidden = false
    let indexPath:IndexPath = IndexPath(row: 0, section: 0)
    self.appVersionCV?.selectItem(at: indexPath, animated: false, scrollPosition: .top)
    let index = homeVM.versions.index( homeVM.versions.startIndex, offsetBy: indexPath.row)
    currentVersion =  homeVM.versions.keys[index]
    homeVM.loadDatabyVersion(version: currentVersion)
  }
  
  @objc func seeMoreDetailsAction() {
    guard let npsItems = homeVM.versions[currentVersion] else { return }
    coordinator?.goToNPSDetail(version:currentVersion, npsItems: npsItems)
  }
}


extension NPSHome: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return homeVM.versions.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if let cell:AppVersionCell = appVersionCV.dequeueReusableCell(withReuseIdentifier: AppVersionCell.identifier, for: indexPath) as? AppVersionCell {
      
      let index = homeVM.versions.index( homeVM.versions.startIndex, offsetBy: indexPath.row)
      
      cell.titleLbl.text = homeVM.versions.keys[index]
      return cell
    }
    
    return UICollectionViewCell()
  }
  
}

extension NPSHome: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    let index = homeVM.versions.index( homeVM.versions.startIndex, offsetBy: indexPath.row)
    currentVersion =  homeVM.versions.keys[index]
    homeVM.loadDatabyVersion(version: currentVersion)
  }
  
}

extension NPSHome: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let totalCell = homeVM.versions.count >= KineduConstants.numCellView ? KineduConstants.numCellView : homeVM.versions.count
    let widthCell = collectionView.bounds.size.width / CGFloat(totalCell)
    let heightCell = collectionView.bounds.size.height
    return CGSize(width: CGFloat(widthCell), height: CGFloat(heightCell))
  }
}
