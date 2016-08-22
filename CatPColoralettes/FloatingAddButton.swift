//
//  FloatingAddButton.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/20/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

protocol FloatingButtonDelegate {
  func didTapFloatingButton()
}

internal class FloatingButton: UIView {
  
  internal var delegate: FloatingButtonDelegate?
  internal static let ButtonSize: CGFloat = 48.0
  internal static var CornerRadius: CGFloat {
    return FloatingButton.ButtonSize * 0.5
  }
  
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    self.snp_makeConstraints { (make) in
      make.size.equalTo(CGSizeMake(FloatingButton.ButtonSize, FloatingButton.ButtonSize))
    }
    
    self.blurryBackgroundView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.tappableControl.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.imageView.snp_makeConstraints { (make) in
      make.center.equalTo(self)
      make.size.equalTo(CGSize(width: FloatingButton.CornerRadius, height: FloatingButton.CornerRadius))
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(blurryBackgroundView)
    self.addSubview(tappableControl)
    self.tappableControl.addSubview(imageView)
    
    self.clipsToBounds = true
    self.layer.cornerRadius = FloatingButton.CornerRadius
  }
  
  
  // MARK: - Actions
  internal func didTap(sender: AnyObject?) {
    self.imageView.tintColor = AppColors.DarkGeoBackgroundTheme

    UIView.animateWithDuration(0.05) {
      self.layer.setAffineTransform(CGAffineTransformMakeScale(0.9, 0.9))
    }
    
    self.delegate?.didTapFloatingButton()
  }
  
  internal func didRelease(sender: AnyObject?) {
    self.imageView.tintColor = AppColors.DefaultTitleText
    
    UIView.animateWithDuration(0.05) {
      self.layer.setAffineTransform(CGAffineTransformIdentity)
    }
  }
  
  
  // MARK: - Lazy Instances
  // TODO: This will need some style adjustment
  lazy internal var blurryBackgroundView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))

  lazy internal var imageView: UIImageView = {
    let view: UIImageView = UIImageView(image: UIImage(named: "plus")!.imageWithRenderingMode(.AlwaysTemplate))
    view.tintColor = AppColors.DefaultTitleText
    view.contentMode = .ScaleAspectFit
    return view
  }()
  
  lazy internal var tappableControl: UIControl = {
    let control: UIControl = UIControl()
    control.addTarget(self, action: #selector(FloatingButton.didTap(_:)), forControlEvents: [.TouchDown])
    control.addTarget(self, action: #selector(FloatingButton.didRelease(_:)),
                      forControlEvents: [.TouchCancel, .TouchDragExit, .TouchDragOutside, .TouchUpInside])
    return control
  }()
}