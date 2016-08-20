//
//  SimpleExpandingCell.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/19/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

internal class SimpleExpandingCell: UITableViewCell {
  internal static let cellIdentifier: String = "SimpleExpandingCellIdentifier"
  private let expansionView = ExpandingView()
  
  
  // MARK: - Initialization
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustSubclass()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    expansionView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.contentView).priority(990.0)
    }
  }
  
  private func setupViewHierarchy() {
    self.contentView.addSubview(expansionView)
  }
  
  private func adjustSubclass() {
    // make any changes to subclass properties
    self.selectionStyle = .None
  }
  
  internal func simulateTap() {
    self.expansionView.toggleCellExpansion()
  }
}



