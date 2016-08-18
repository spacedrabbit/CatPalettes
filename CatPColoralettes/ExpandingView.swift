//
//  ExpandingView.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit

class ExpandingView: UIView {
  
  internal var primaryContentView: UIView = UIView()
  internal var secondaryContentView: UIView = UIView()
  
  private var secondaryContentViewBottomConstraint: Constraint?

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    self.setupViewHierarchy()
    self.configureConstraints()
    
    primaryContentView.backgroundColor = UIColor(red: randomZeroToOne(), green: randomZeroToOne(), blue: randomZeroToOne(), alpha: 1.0)
    secondaryContentView.backgroundColor = primaryContentView.backgroundColor?.colorWithAlphaComponent(0.25)
  }

  private func configureConstraints() {
    self.primaryContentView.snp_makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.width.equalTo(self).priority(990.0)
      make.height.equalTo(20.0)
    }
    
    self.secondaryContentView.snp_makeConstraints { (make) in
      make.top.equalTo(self.primaryContentView.snp_bottom)
      make.bottom.left.right.equalTo(self)
      make.width.equalTo(self).priority(990.0)
      self.secondaryContentViewBottomConstraint = make.height.equalTo(0.0).constraint
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(primaryContentView)
    self.addSubview(secondaryContentView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  internal func animateCell(expand: Bool) {
    
    if expand {
      self.secondaryContentViewBottomConstraint?.deactivate()
      
      self.secondaryContentView.snp_updateConstraints(closure: { (make) in
        make.height.equalTo(24.0)
      })
      
      UIView.animateWithDuration(0.15, animations: { 
        self.layoutIfNeeded()
        }, completion: nil) // TODO: update this to do something if needed
      
    } else {
      
      self.secondaryContentViewBottomConstraint?.activate()
      UIView.animateWithDuration(0.15, animations: {
        self.layoutIfNeeded()
        }, completion: nil) // TODO: update this to do something if needed

    }
    
  }
  
}
