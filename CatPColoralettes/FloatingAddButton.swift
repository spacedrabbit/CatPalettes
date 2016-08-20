//
//  FloatingAddButton.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/20/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal class FloatingButton: UIControl {
  internal static let ButtonSize: CGFloat = 48.0
  internal static var CornerRadius: CGFloat {
    return FloatingButton.ButtonSize * 0.5
  }
  
  internal var plusIcon: UIImage = UIImage(named: "plus")!
  internal var imageView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    plusIcon.imageWithRenderingMode(.AlwaysTemplate)
    self.imageView = UIImageView(image: plusIcon)
    self.imageView.tintColor = AppColors.DefaultTitleText
    self.imageView.contentMode = .ScaleAspectFit
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  private func configureConstraints() {
    self.snp_makeConstraints { (make) in
      make.size.equalTo(CGSizeMake(FloatingButton.ButtonSize, FloatingButton.ButtonSize))
    }
    
    self.blurryBackgroundView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.imageView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(blurryBackgroundView)
    self.addSubview(imageView)
    
    self.clipsToBounds = true
    self.layer.cornerRadius = FloatingButton.CornerRadius
  }
  
  lazy internal var blurryBackgroundView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
}