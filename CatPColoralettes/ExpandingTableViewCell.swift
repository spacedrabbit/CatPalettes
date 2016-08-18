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
  internal var arrangedSubviews: [UIView] = [UIView(), UIView(), UIView(), UIView()]
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    self.palatteStackView = UIStackView(arrangedSubviews: self.arrangedSubviews)
    self.palatteStackView.axis = .Vertical
    self.palatteStackView.distribution = .FillEqually
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    for view in self.palatteStackView.arrangedSubviews {
      view.backgroundColor = UIColor.init(red: randomZeroToOne(), green: randomZeroToOne(), blue: randomZeroToOne(), alpha: 1.0)
      view.frame = CGRectMake(0.0, 0.0, self.contentView.frame.width, 20.0)
    }
    
    self.contentView.addSubview(self.palatteStackView)
    
    self.palatteStackView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.contentView)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
}
