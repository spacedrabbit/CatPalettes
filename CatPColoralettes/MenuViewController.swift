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
    self.addButtonBehaviours()
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
  
  internal func addButtonBehaviours() {
    self.palettesButton.addTarget(self, action: #selector(MenuViewController.menuSelectionMade(_:)), forControlEvents: .TouchUpInside)
    self.gradientsButton.addTarget(self, action: #selector(MenuViewController.menuSelectionMade(_:)), forControlEvents: .TouchUpInside)
    self.settingsButton.addTarget(self, action: #selector(MenuViewController.menuSelectionMade(_:)), forControlEvents: .TouchUpInside)
    self.profileButton.addTarget(self, action: #selector(MenuViewController.menuSelectionMade(_:)), forControlEvents: .TouchUpInside)
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Routing
  private func route(forSelectedButton button: UIButton) -> BasePaletteViewController {
    
    var returnedVC = BasePaletteViewController()
    switch button.tag {
    case AppMenuButton.Palette.rawValue:
      print("palette selected")
      returnedVC = PaletteViewController()
      
    case AppMenuButton.Gradient.rawValue:
      print("gradient selected")
      
    case AppMenuButton.Profile.rawValue:
      print("profile tapped")
      
    case AppMenuButton.Settings.rawValue:
      print("settings tapped")
      
    default:
      print("Unknown tapped")
    }
    
    return returnedVC
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Actions
  /**
    Checks for the sender's tag (will always be a UIButton for now) to determine which selection a user made in the menu.
    Then verifies that the RESideMenu's contentView is a UINavigationController before proceeding. After the destination 
    view controller is determined, this is compared against the top view controller of the UINavigationController's stack.
    If it is the same, the menu simply closes. However, if it is a different VC type then we push the new VC onto the 
    navigation stack, and make that VC the only member of the stack. 
   
    By design, only the topVC should be on the navigation stack when making a selection from the menu.
   */
  internal func menuSelectionMade(sender: AnyObject?) {
    if let button: UIButton = sender as? UIButton {
      if let navVC: UINavigationController = MenuManager.contentViewController as? UINavigationController {
        
        let destinationVC = self.route(forSelectedButton: button)
        if !MenuManager.shared.previousViewController(wasType: destinationVC) {
          navVC.pushViewController(destinationVC, animated: true)
          navVC.viewControllers = [destinationVC]
        }
        
        MenuManager.shared.managedMenu.hideMenuViewController()
      }
    }
  }
  

  // ---------------------------------------------------------------- //
  // MARK: - Other
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
    button.tag = AppMenuButton.Palette.rawValue
    return button
  }()
  
  internal lazy var gradientsButton: UIButton = {
    let button: UIButton = UIButton()
    button.setTitle(AppStrings.GradientsTitle, forState: .Normal)
    button.titleLabel?.font = AppFonts.MenuButtonText
    button.titleLabel?.textColor = AppColors.DefaultTitleText
    button.tag = AppMenuButton.Gradient.rawValue
    return button
  }()
  
  internal lazy var settingsButton: UIButton = {
    let button: UIButton = UIButton()
    button.setTitle(AppStrings.SettingsTitle, forState: .Normal)
    button.titleLabel?.font = AppFonts.MenuButtonText
    button.titleLabel?.textColor = AppColors.DefaultTitleText
    button.tag = AppMenuButton.Settings.rawValue
    return button
  }()
  
  internal lazy var profileButton: UIButton = {
    let button: UIButton = UIButton()
    button.setTitle(AppStrings.ProfileTitle, forState: .Normal)
    button.titleLabel?.font = AppFonts.MenuButtonText
    button.titleLabel?.textColor = AppColors.DefaultTitleText
    button.tag = AppMenuButton.Palette.rawValue
    return button
  }()
}
