//
//  SimpleTableTitleView.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/21/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal class SimpleTableTitleView: UIView {
  
  convenience init(withTitle title: String) {
    self.init(frame: CGRectZero)
    self.titleLabel.text = title
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  private func configureConstraints() {
    self.titleLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self).offset(16.0).priority(990.0)
      make.bottom.equalTo(self).offset(-16.0).priority(990.0)
      make.left.equalTo(self)
      make.right.lessThanOrEqualTo(self)
      make.height.equalTo(24.0)
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(titleLabel)
    self.backgroundColor = AppColors.LightGeoBackgroundTheme
  }
  
  internal lazy var titleLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = AppFonts.Header
    label.textAlignment = .Left
    label.textColor = AppColors.DefaultTitleText
    return label
  }()
  
}