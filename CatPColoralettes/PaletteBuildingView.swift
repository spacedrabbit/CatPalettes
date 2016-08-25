//
//  PaletteBuildingView.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/24/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit

internal class PaletteBuildingView: UIView {
  internal var colors: [UIColor]?
  
  // ---------------------------------------------------------------- //
  // MARK: - Init
  convenience init(withPaletteColors colors: [UIColor]?) {
    self.init(frame: CGRectZero)
    self.colors = colors
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Setup
  private func configureConstraints() {
    self.scrollingView.snp_makeConstraints { (make) in
      make.edges.width.height.equalTo(self)
    }
    
    self.stackView.snp_makeConstraints { (make) in
      make.edges.equalTo(self.scrollingView)
      make.width.right.equalTo(self)
    }
  }
  
  private func setupViewHierarchy() {
    self.addSubview(scrollingView)
    self.scrollingView.addSubview(stackView)
    
    if let validColors = self.colors {
      for color in validColors {
        let singleEdit = SingleColorEditView(withColor: color)
        self.stackView.addArrangedSubview(singleEdit)
      }
    }
  }

  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Instances
  internal lazy var stackView: UIStackView = {
    let stack = UIStackView()
    stack.distribution = .FillEqually
    stack.axis = .Vertical
    return stack
  }()
  
  internal lazy var scrollingView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.bounces = true
    scroll.showsVerticalScrollIndicator = true
    return scroll
  }()
}