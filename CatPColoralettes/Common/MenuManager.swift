//
//  MenuManager.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/22/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit
import RESideMenu

internal class MenuManager: NSObject, RESideMenuDelegate {
  internal private (set) var managedMenu: RESideMenu!
  internal static var shared: MenuManager = MenuManager()
  
  private override init() {}
  private convenience init(withSideMenu menu: RESideMenu) {
    self.init()
    self.managedMenu = menu
    self.managedMenu.delegate = self
  }
  
  internal class func initialize(withMenu menu: RESideMenu) {
    MenuManager.shared = MenuManager(withSideMenu: menu)
  }
  
  // ---------------------------------------------------------------- //
  // MARK: - RESideMenu Delegate
  func sideMenu(sideMenu: RESideMenu!, didRecognizePanGesture recognizer: UIPanGestureRecognizer!) {
    
    // note: this will disable the right pan entirely, even when you're in the left menu
    // I don't know if i like this, and might just remove it in favor of a different solution
    sideMenu.panGestureEnabled = true
    if recognizer.translationInView(nil).x <= 0 { // pan from right
      sideMenu.panGestureEnabled = false
    }
  }
  
  func sideMenu(sideMenu: RESideMenu!, didHideMenuViewController menuViewController: UIViewController!) {
  }
  
  func sideMenu(sideMenu: RESideMenu!, didShowMenuViewController menuViewController: UIViewController!) {
    if menuViewController == sideMenu.leftMenuViewController {
      if let menuScreen: MenuViewController = menuViewController as? MenuViewController {
        print("access grante")
      }
    }

  }
  
  func sideMenu(sideMenu: RESideMenu!, willHideMenuViewController menuViewController: UIViewController!) {
    
  }
  
  func sideMenu(sideMenu: RESideMenu!, willShowMenuViewController menuViewController: UIViewController!) {
    
  }
  
}
