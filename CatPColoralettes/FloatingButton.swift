//
//  FloatingButton.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/20/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

enum FloatingButtonAction {
  case Plus, Minus
}

enum FloatingButtonSize {
  case Large, Small
}

protocol FloatingButtonDelegate: class {
  func didTapFloatingButton(withAction action: FloatingButtonAction)
}

internal class FloatingButton: UIView {
  
  internal weak var delegate: FloatingButtonDelegate?
  internal var imageInUse: UIImageView?
  internal var action: FloatingButtonAction?
  
  internal static let LargeButtonSize: CGFloat = 48.0
  internal static let SmallButtonSize: CGFloat = 24.0
  internal var selectedSize: CGFloat!
  
  
  // MARK: - Init
  convenience init(withAction action: FloatingButtonAction, size: FloatingButtonSize = .Large) {
    self.init(frame: CGRectZero)
    
    // not the best of design choice, but easiest to rewrite now and since both imageViews are lazy, shouldn't impact performance
    switch action {
    case .Plus:
      self.imageInUse = self.imagePlusView
      self.action = action
    case .Minus:
      self.imageInUse = self.imageMinusView
      self.action = action
    }
    
    switch size {
    case .Large: self.selectedSize = FloatingButton.LargeButtonSize
    case .Small: self.selectedSize = FloatingButton.SmallButtonSize
    }
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    self.snp_makeConstraints { (make) in
      make.size.equalTo(CGSizeMake(self.selectedSize, self.selectedSize))
    }
    
    self.blurryBackgroundView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.tappableControl.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.imageInUse!.snp_makeConstraints { (make) in
      make.center.equalTo(self)
      make.size.equalTo(CGSize(width: self.selectedSize * 0.5, height: self.selectedSize * 0.5))
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(blurryBackgroundView)
    self.addSubview(tappableControl)
    self.tappableControl.addSubview(self.imageInUse!)
    
    self.clipsToBounds = true
    self.layer.cornerRadius = self.selectedSize * 0.5
  }
  
  
  // MARK: - Actions
  internal func didTap(sender: AnyObject?) {
    self.imageInUse?.tintColor = AppColors.DarkGeoBackgroundTheme

    UIView.animateWithDuration(0.05) {
      self.layer.setAffineTransform(CGAffineTransformMakeScale(0.9, 0.9))
    }
  }
  
  internal func didRelease(sender: AnyObject?) {
    self.imageInUse?.tintColor = AppColors.DefaultTitleText
    
    UIView.animateWithDuration(0.05) {
      self.layer.setAffineTransform(CGAffineTransformIdentity)
    }
    
    self.delegate?.didTapFloatingButton(withAction: self.action!)
  }
  
  
  // MARK: - Lazy Instances
  // TODO: This will need some style adjustment
  lazy internal var blurryBackgroundView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))

  lazy internal var imagePlusView: UIImageView = {
    let view: UIImageView = UIImageView(image: UIImage(named: "plus")!.imageWithRenderingMode(.AlwaysTemplate))
    view.tintColor = AppColors.DefaultTitleText
    view.contentMode = .ScaleAspectFit
    return view
  }()
  
  lazy internal var imageMinusView: UIImageView = {
    let view: UIImageView = UIImageView(image: UIImage(named: "minus")!.imageWithRenderingMode(.AlwaysTemplate))
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