//
//  ExpandingView.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit

/** 
  Simple UIView subclass with a tap gesture recognizer to expand/shrink it's height
 */
class ExpandingView: UIView {
  internal static let ColorViewHeight: CGFloat = 36.0
  internal static let OptionsViewHeight: CGFloat = 24.0

  internal var colorViews: [UIView] = []
  internal lazy var stackView: UIStackView = {
    let stack: UIStackView = UIStackView()
    stack.alignment = .Fill
    stack.distribution = .FillEqually
    stack.axis = .Vertical
    return stack
  }()
  internal var optionsView: UIView = UIView()
  internal var containerView: UIView = {
    let view: UIView = UIView()
    view.clipsToBounds = true
    view.layer.cornerRadius = 15.0
    return view
  }()
  internal var overlayView: UIView = UIView()
  
  private var tapRecognizer: UITapGestureRecognizer!
  private var optionsViewTopConstrain: Constraint?
  internal private (set) var isExpanded: Bool = false
  
  
  // MARK: Initialization
  convenience init(withColors colors: [UIColor]) {
    self.init(frame: CGRectZero)
    colors.forEach { (color) in
      let view: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: ExpandingView.ColorViewHeight))
      view.backgroundColor = color
      self.colorViews.append(view)
    }
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.addGestures()
    
    self.optionsView.backgroundColor = UIColor.cyanColor()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  // MARK: Setup
  private func configureConstraints() {
    self.containerView.snp_makeConstraints { (make) in
      make.edges.equalTo(self)
    }
    
    self.overlayView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.containerView)
    }
    
    self.stackView.snp_makeConstraints { (make) in
      make.top.left.right.equalTo(self.containerView)
    }
    
    self.optionsView.snp_makeConstraints { (make) in
      make.bottom.left.right.equalTo(self.containerView)
      make.height.equalTo(ExpandingView.OptionsViewHeight)
      self.optionsViewTopConstrain = make.top.equalTo(self.stackView.snp_bottom).offset(-ExpandingView.OptionsViewHeight).constraint
    }
    
    self.stackView.arrangedSubviews.forEach { (view) in
      view.snp_makeConstraints(closure: { (make) in
        make.height.equalTo(ExpandingView.ColorViewHeight)
      })
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(containerView)
    
    self.containerView.addSubview(optionsView)
    self.containerView.addSubview(stackView)
    self.containerView.addSubview(overlayView)
    
    self.colorViews.forEach { (view) in
      self.stackView.addArrangedSubview(view)
    }
  }
  
  // TODO: remove gesture if def staying with tableview delegate handling it
  private func addGestures() {
    self.tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExpandingView.didTapView))
    self.addGestureRecognizer(self.tapRecognizer)
    self.tapRecognizer.cancelsTouchesInView = false
  }
  
  
  // MARK: - Animation
  internal func toggleCellExpansion() {
    
    let newOffset = self.isExpanded ? -ExpandingView.OptionsViewHeight : ExpandingView.OptionsViewHeight
    self.optionsViewTopConstrain?.updateOffset(newOffset)
    self.layoutIfNeeded()
    
    self.isExpanded = !self.isExpanded
  }

  
  // MARK: - Gestures 
  internal func didTapView(sender: AnyObject?) {
    // not being utilized at the moment, cell directly is calling toggle cell expansion on tap
  }
}
