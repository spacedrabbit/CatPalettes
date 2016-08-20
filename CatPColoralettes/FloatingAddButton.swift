//
//  FloatingAddButton.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/20/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal class FloatingButton: UIView {
  internal static let ButtonSize: CGFloat = 48.0
  internal static var CornerRadius: CGFloat {
    return FloatingButton.ButtonSize * 0.5
  }

  lazy internal var imageView: UIImageView = {
    let view: UIImageView = UIImageView(image: UIImage(named: "plus")!.imageWithRenderingMode(.AlwaysTemplate))
    view.tintColor = AppColors.DefaultTitleText
    view.contentMode = .ScaleAspectFit
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
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
      make.center.equalTo(self)
      make.size.equalTo(CGSize(width: FloatingButton.CornerRadius, height: FloatingButton.CornerRadius))
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(blurryBackgroundView)
    self.addSubview(imageView)
    
    self.clipsToBounds = true
    self.blurryBackgroundView.alpha = 0.5
    self.layer.cornerRadius = FloatingButton.CornerRadius
  }
  
  // TODO: This will need some style adjustment
  lazy internal var blurryBackgroundView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
  // TODO: switch image view to be a UIControl and add image to it as subview. then adjust the control states
  
}