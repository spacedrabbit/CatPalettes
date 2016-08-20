//
//  SimpleHeaderView.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/20/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal class SimpleHeaderView: UIView {
  internal static let StandardHeight: CGFloat = 24.0
  
  convenience init(withTitle title: String) {
    self.init(frame: CGRectZero)
    self.titleLabel.text = title
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustSubclass()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  private func configureConstraints() {
    self.snp_makeConstraints { (make) in
      make.height.greaterThanOrEqualTo(SimpleHeaderView.StandardHeight)
    }
    
    self.titleLabel.snp_makeConstraints { (make) in
      make.left.centerY.equalTo(self)
      make.right.lessThanOrEqualTo(self)
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(titleLabel)
  }
  
  private func adjustSubclass() {
    // make any changes to subclass properties
    // TODO: remove debug colors
    self.backgroundColor = UIColor.brownColor() //AppColors.DefaultBackground
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  internal lazy var titleLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = AppFonts.SectionTitle
    label.textColor = AppColors.DefaultTitleText
    return label
  }()
}


