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
  
  private var tapRecognizer: UITapGestureRecognizer!
  private var isExpanded: Bool = false
  
  private var secondaryHeightConstraint: Constraint?
  
  // MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()

    self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExpandingView.didTapView))
    self.addGestureRecognizer(self.tapRecognizer)
    self.tapRecognizer.cancelsTouchesInView = false
    
    primaryContentView.backgroundColor = UIColor.blueColor() //UIColor(red: randomZeroToOne(), green: randomZeroToOne(), blue: randomZeroToOne(), alpha: 1.0)
    secondaryContentView.backgroundColor = primaryContentView.backgroundColor?.colorWithAlphaComponent(0.25)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  // MARK: Setup
  private func configureConstraints() {
    self.primaryContentView.snp_makeConstraints { (make) in
      make.top.left.right.equalTo(self)
      make.height.equalTo(20.0)
    }
    
    self.secondaryContentView.snp_makeConstraints { (make) in
      make.top.equalTo(self.primaryContentView.snp_bottom)
      make.left.right.bottom.equalTo(self)
      make.height.equalTo(0.0)
    }
  }
  
  
  private func setupViewHierarchy() {
    self.addSubview(primaryContentView)
    self.addSubview(secondaryContentView)
  }
  
  
  // MARK: - Animation
  internal func toggleCellExpansion() {
    let newHeight = self.isExpanded ? 0.0 : 22.0

    UIView.animateWithDuration(0.15, animations: {

      self.secondaryContentView.snp_updateConstraints { (make) in
        make.height.equalTo(newHeight)
      }
      self.layoutIfNeeded()
      
      }, completion: nil)
    
    self.isExpanded = !self.isExpanded
  }

  // MARK: - Gestures 
  internal func didTapView(sender: AnyObject?) {
    // print("Expanding view was tapped")
    self.toggleCellExpansion()
  }
}
