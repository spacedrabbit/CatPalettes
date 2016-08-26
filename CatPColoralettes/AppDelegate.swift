//
//  AppDelegate.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import RESideMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let rootVC = PaletteViewController()
    let navigationController: UINavigationController = UINavigationController(rootViewController: rootVC)
    navigationController.navigationBar.barTintColor = AppColors.LightGeoBackgroundTheme
    navigationController.navigationBar.titleTextAttributes = [
      NSForegroundColorAttributeName : AppColors.DefaultTitleText,
      NSFontAttributeName : AppFonts.Header
    ]

    // TODO: test with background image and adjust parallax settings
    let menu: MenuViewController = MenuViewController()
    let slidingNavigationMenu: RESideMenu = RESideMenu(contentViewController: navigationController,
                                                       leftMenuViewController: menu,
                                                       rightMenuViewController: ViewController())
    slidingNavigationMenu.bouncesHorizontally = false
    slidingNavigationMenu.animationDuration = 0.25
    slidingNavigationMenu.backgroundImage = UIImage(named: "geo_background")
    slidingNavigationMenu.menuPreferredStatusBarStyle = .LightContent
    
    MenuManager.initialize(withMenu: slidingNavigationMenu)
    
    self.testJSON()
    
    self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    self.window?.rootViewController = slidingNavigationMenu //navigationController
    self.window?.makeKeyAndVisible()
    
    return true
  }
  
  internal func testJSON() {
    DataManager.shared.storePalettes([ColorPalette(name: "test", colors: nil)])
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

