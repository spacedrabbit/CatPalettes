//
//  PaletteBuildingView.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/24/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

internal class PaletteBuildingView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  internal lazy var stackView: UIStackView = {
    let stack = UIStackView()
    stack.distribution = .FillEqually
    stack.axis = .Vertical
    return stack
  }()
  
  internal lazy var scrollingView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.bounces = false
    scroll.showsVerticalScrollIndicator = false
    return scroll
  }()
}


internal class SingleColorEditView: UIView, FloatingButtonDelegate {
  
  internal var previewedColor: UIColor? {
    willSet {
      self.colorPreviewView.backgroundColor = newValue
    }
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Inits
  convenience init(withColor color: UIColor?) {
    self.init(frame: CGRectZero)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustViewsForColor(color)
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Setup
  private func configureConstraints() {
    self.colorPreviewView.snp_makeConstraints { (make) in
      make.left.equalTo(self).offset(16.0)
      make.right.equalTo(self.snp_centerX)
      make.top.equalTo(self).offset(8.0)
      make.bottom.equalTo(self).inset(8.0)
      
      make.height.equalTo(24.0)
    }
    
    self.buttonContainer.snp_makeConstraints { (make) in
      make.top.bottom.centerY.equalTo(colorPreviewView)
      make.right.equalTo(self).inset(16.0)
    }
    
    self.buttonStackView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.buttonContainer)
    }
    
    self.instructionsLabel.snp_makeConstraints { (make) in
      make.top.bottom.centerX.height.equalTo(colorPreviewView)
      make.width.lessThanOrEqualTo(colorPreviewView)
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(colorPreviewView)
    self.addSubview(buttonContainer)
    
    self.buttonContainer.addSubview(buttonStackView)
    self.buttonStackView.addArrangedSubview(self.plusButton)
  
    self.colorPreviewView.addSubview(instructionsLabel)
    
    self.plusButton.delegate = self
  }
  
  internal func adjustViewsForColor(color: UIColor?) {
    
    if let validColor: UIColor = color {
      self.colorPreviewView.backgroundColor = validColor
      self.colorPreviewView.layer.borderWidth = 0.0
      self.instructionsLabel.hidden = true
      
      self.buttonStackView.addArrangedSubview(self.minusButton)
      self.minusButton.delegate = self
    }
    else {
      self.colorPreviewView.backgroundColor = AppColors.Clear
      self.colorPreviewView.layer.borderColor = AppColors.DefaultTitleText.CGColor
      self.colorPreviewView.layer.borderWidth = 2.0
      self.instructionsLabel.hidden = false
      
      self.buttonStackView.removeArrangedSubview(self.minusButton)
    }
    
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Floating Button Delegate
  func didTapFloatingButton(withAction action: FloatingButtonAction) {
    switch action {
    case .Plus:
      // TODO: remove after testing
      print("floating button detected +")
      self.adjustViewsForColor(randomColor())
    
    case .Minus:
      // TODO: remove after testing
      print("floating button detected -")
      self.adjustViewsForColor(nil)
    }
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Instances
  internal lazy var buttonStackView: UIStackView = {
    let stack: UIStackView = UIStackView()
    stack.axis = .Horizontal
    stack.distribution = .EqualSpacing
    stack.spacing = 8.0
    return stack
  }()
  
  internal lazy var colorPreviewView: UIView = {
    let view: UIView = UIView()
    view.clipsToBounds = true
    view.layer.cornerRadius = 10.0
    return view
  }()
  
  internal lazy var plusButton: FloatingButton = FloatingButton(withAction: .Plus, size: .Small)
  internal lazy var minusButton: FloatingButton = FloatingButton(withAction: .Minus, size: .Small)
  internal lazy var buttonContainer: UIView = UIView()
  internal lazy var instructionsLabel: UILabel = {
    let label: UILabel = UILabel()
    label.textColor = AppColors.DefaultTitleText
    label.font = AppFonts.SectionTitle
    label.numberOfLines = 1
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
}