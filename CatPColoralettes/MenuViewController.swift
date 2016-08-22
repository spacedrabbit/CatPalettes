//
//  MenuViewController.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/22/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import RESideMenu
import SnapKit

class MenuViewController: UIViewController {
  private static let LeftMargin: CGFloat = 24.0
  private static let VerticalMargin: CGFloat = 16.0
  private static let TopOffsetMultiplier: CGFloat = 0.25
  
  // ---------------------------------------------------------------- //
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.setupViewHierarchy()
    self.configureConstraints()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  
  // ---------------------------------------------------------------- //
  // MARK: - Setup
  private func configureConstraints() {
    self.containerView.snp_makeConstraints { (make) in
      make.left.right.equalTo(self.view)
      make.top.equalTo(self.view.snp_top).offset(self.view.frame.height * MenuViewController.TopOffsetMultiplier)
    }

    self.palettesButton.snp_makeConstraints { (make) in
      make.top.equalTo(containerView)
      make.left.equalTo(containerView).offset(MenuViewController.LeftMargin)
    }
    
    self.gradientsButton.snp_makeConstraints { (make) in
      make.left.equalTo(containerView).offset(MenuViewController.LeftMargin)
      make.top.equalTo(self.palettesButton.snp_bottom).offset(MenuViewController.VerticalMargin)
    }
    
    self.settingsButton.snp_makeConstraints { (make) in
      make.left.equalTo(containerView).offset(MenuViewController.LeftMargin)
      make.top.equalTo(self.gradientsButton.snp_bottom).offset(MenuViewController.VerticalMargin)
    }
    
    self.profileButton.snp_makeConstraints { (make) in
      make.left.equalTo(containerView).offset(MenuViewController.LeftMargin)
      make.top.equalTo(self.settingsButton.snp_bottom).offset(MenuViewController.VerticalMargin)
      make.bottom.equalTo(containerView)
    }
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(containerView)
    self.view.backgroundColor = AppColors.Clear
    
    self.containerView.addSubview(palettesButton)
    self.containerView.addSubview(gradientsButton)
    self.containerView.addSubview(settingsButton)
    self.containerView.addSubview(profileButton)
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }

  // ---------------------------------------------------------------- //
  // MARK: - Lazy Instances
  internal lazy var containerView: UIView = UIView()
  
  internal lazy var palettesButton: UIButton = {
    let button: UIButton = UIButton()
    button.setTitle(AppStrings.PaletteVCTile, forState: .Normal)
    button.titleLabel?.font = AppFonts.MenuButtonText
    button.titleLabel?.textColor = AppColors.DefaultTitleText
    return button
  }()
  
  internal lazy var gradientsButton: UIButton = {
    let button: UIButton = UIButton()
    button.setTitle(AppStrings.GradientsTitle, forState: .Normal)
    button.titleLabel?.font = AppFonts.MenuButtonText
    button.titleLabel?.textColor = AppColors.DefaultTitleText
    return button
  }()
  
  internal lazy var settingsButton: UIButton = {
    let button: UIButton = UIButton()
    button.setTitle(AppStrings.SettingsTitle, forState: .Normal)
    button.titleLabel?.font = AppFonts.MenuButtonText
    button.titleLabel?.textColor = AppColors.DefaultTitleText
    return button
  }()
  
  internal lazy var profileButton: UIButton = {
    let button: UIButton = UIButton()
    button.setTitle(AppStrings.ProfileTitle, forState: .Normal)
    button.titleLabel?.font = AppFonts.MenuButtonText
    button.titleLabel?.textColor = AppColors.DefaultTitleText
    return button
  }()
}
