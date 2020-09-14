//
//  LoadingView.swift
//  KineduNPS
//
//  Created by Hector Climaco on 14/09/20.
//  Copyright © 2020 Hector. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    static let nibName = "LoadingView"
    //MARK: Outlets
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(LoadingView.nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.layer.masksToBounds = true
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func configure(_ view:UIView) {
           self.frame.size = view.frame.size
    }

}
