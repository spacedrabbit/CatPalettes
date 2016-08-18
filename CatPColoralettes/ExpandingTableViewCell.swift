//
//  ExpandingTableViewCell.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit

internal func randomZeroToOne() -> CGFloat {
  return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
}

class ExpandingTableViewCell: UITableViewCell {
  internal static let expandingIdentifier: String = "expandingCellIdentifier"
  
  internal var palatteStackView: UIStackView
  internal var arrangedSubviews: [UIView] = [ExpandingView(), ExpandingView(), ExpandingView(), ExpandingView()]
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    self.palatteStackView = UIStackView(arrangedSubviews: self.arrangedSubviews)
    self.palatteStackView.axis = .Vertical

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustSubclass()
  }
  
  
  // MARK: CatThoughts Setup Functions
  private func configureConstraints() {
    self.palatteStackView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.contentView)
    }
  }
  
  private func setupViewHierarchy() {
    self.contentView.addSubview(self.palatteStackView)
  }
  
  private func adjustSubclass() {
    // make any changes to subclass properties
    self.selectionStyle = .None
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  
}
