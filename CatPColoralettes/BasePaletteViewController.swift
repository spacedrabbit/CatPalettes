//
//  BasePaletteViewController.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/23/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal class BasePaletteViewController: UIViewController {
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.updateNavigationBar()
  }
  
  internal func updateNavigationBar() {
    let menuBarButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "palette")?.imageWithRenderingMode(.AlwaysTemplate),
                                                         style: .Plain,
                                                         target: self,
                                                         action: #selector(BasePaletteViewController.paletteButtonTapped))
    self.navigationController?.navigationBar.tintColor = AppColors.DefaultTitleText
    self.navigationItem.setLeftBarButtonItem(menuBarButton, animated: false)
  }
  
  internal func paletteButtonTapped() {
    fatalError("This must be overriden in subclass")
  }
  
  internal func showMenu(sender: AnyObject?) {
    self.navigationController?.presentLeftMenuViewController(self)
  }
}

