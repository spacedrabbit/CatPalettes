//
//  ExpandingTableViewCell.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit


// NOTE: This is subclass is going to be tabled for now.. it's going to require much more work than I'd like to put into this project
// to get a stack view to behave in the manner I'd like
class ExpandingTableViewCell: UITableViewCell {
  internal static let expandingIdentifier: String = "expandingCellIdentifier"
  
  internal var palatteStackView: UIStackView
  internal var arrangedSubviews: [UIView] = [ExpandingView(), ExpandingView(), ExpandingView(), ExpandingView()]
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    self.palatteStackView = UIStackView(arrangedSubviews: self.arrangedSubviews)
    self.palatteStackView.axis = .Vertical
    self.palatteStackView.alignment = .Fill

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustSubclass()
  }
  
  
  // MARK: CatThoughts Setup Functions
  private func configureConstraints() {
    self.palatteStackView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.contentView).priorityHigh()
    }
  }
  
  private func setupViewHierarchy() {
    self.contentView.addSubview(self.palatteStackView)
  }
  
  private func adjustSubclass() {
    self.selectionStyle = .None
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}
