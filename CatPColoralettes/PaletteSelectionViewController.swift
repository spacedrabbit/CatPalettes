//
//  PaletteSelectionViewController.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/23/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit

class PaletteSelectionViewController: UIViewController, SwiftHSVColorPickerDelegate {
  
  internal var colorPicker: SwiftHSVColorPicker!
  
  // ---------------------------------------------------------------- //
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // does not play well with autolayout, must manually create frame
    self.colorPicker = SwiftHSVColorPicker(frame: CGRect(x: 0.0,
      y: 0.0,
      width: self.view.frame.size.width,
      height: self.view.frame.size.height * 0.5))
    
    self.colorPicker.delegate = self
    self.colorPicker.setViewColor(AppColors.LightGeoBackgroundTheme)
    self.updateLabelsFor(self.colorPicker.color)
    
    self.setupViewHierarchy()
    self.configureConstraints()
  
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Setup
  private func configureConstraints() {
    
    self.currentColorDetailsRGBLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.colorPicker.snp_bottom).offset(16.0)
      make.centerX.equalTo(self.view)
    }
    
    self.currentColorDetailsHexLabel.snp_makeConstraints { (make) in
      make.top.equalTo(self.currentColorDetailsRGBLabel.snp_bottom).offset(12.0)
      make.centerX.equalTo(self.view)
    }
    
    self.expandingView.snp_makeConstraints { (make) in
      make.top.equalTo(self.currentColorDetailsHexLabel.snp_bottom).offset(24.0)
      make.left.right.equalTo(self.view)
    }
    
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(self.colorPicker)
    self.view.addSubview(self.expandingView)
    self.view.addSubview(self.currentColorDetailsRGBLabel)
    self.view.addSubview(self.currentColorDetailsHexLabel)
    
    self.view.backgroundColor = AppColors.DarkGeoBackgroundTheme
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - UI Updates 
  private func updateLabelsFor(color: UIColor) {
    let rgbComponents = rgbComponentsFrom(color)
    let hexString = hexValueFrom(color)
    self.currentColorDetailsRGBLabel.text = "R: \(Double(rgbComponents.r).roundToPlaces(1)), G: \(Double(rgbComponents.g).roundToPlaces(1)), B: \(Double(rgbComponents.b).roundToPlaces(1))"
    self.currentColorDetailsHexLabel.text = "#" + hexString
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Color Picking Delegate
  internal func didSelectColor(color: UIColor) {
    self.updateLabelsFor(color)
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Instances
  internal lazy var expandingView: ExpandingView = {
    let view: ExpandingView = ExpandingView(withColors: [UIColor.redColor(), UIColor.blueColor()])
    return view
  }()
  
  internal lazy var currentColorDetailsRGBLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = AppFonts.SectionTitle
    label.textColor = AppColors.DefaultTitleText
    return label
  }()
  
  internal lazy var currentColorDetailsHexLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = AppFonts.SectionTitle
    label.textColor = AppColors.DefaultTitleText
    return label
  }()
}
