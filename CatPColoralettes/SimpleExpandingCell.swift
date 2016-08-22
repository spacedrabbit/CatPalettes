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
  internal private (set) var expansionView: ExpandingView!// = ExpandingView()
  
  
  // MARK: - Initialization
  convenience init(style: UITableViewCellStyle, reuseIdentifier: String?, palette: ColorPalette) {
    self.init(style: style, reuseIdentifier: reuseIdentifier)
    self.expansionView = ExpandingView(withColors: palette.paletteColors)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustSubclass()
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    self.backgroundColor = AppColors.LightGeoBackgroundTheme
  }
  
  internal func simulateTap() {
    print("simulated tap")
    self.expansionView.toggleCellExpansion()
  }
}



