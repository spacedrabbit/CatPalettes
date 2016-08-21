//
//  PaletteTableViewController.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

internal class PaletteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - Instance Vars
  internal var paletteManager: ExpandingViewGroupManager!
  internal var debugPaletteManager: ExpandingViewGroupManager!
  internal var floatingPlusButton: FloatingButton = FloatingButton()
  internal var debugPallete: [ColorPalette] {
    return [
      ColorPalette(name: "Debug Primary", colors: [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor()]),
      ColorPalette(name: "Debug Secondary", colors: [UIColor.purpleColor(), UIColor.orangeColor(), UIColor.greenColor()])
    ]
  }
  
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.debugPaletteManager = ExpandingViewGroupManager(withPalettes: self.debugPallete)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustSubclass()
  }
  
  // private catthoughts setup functions
  private func configureConstraints() {
    self.tableView.snp_makeConstraints { (make) in
      make.size.equalTo(self.view.snp_size)
      make.edges.equalTo(self.view)
    }
    
    self.floatingPlusButton.snp_makeConstraints { (make) in
      make.bottom.equalTo(self.view).offset(-FloatingButton.CornerRadius - 40.0)
      make.centerX.equalTo(self.view)
    }
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(self.tableView)
    self.view.addSubview(floatingPlusButton)
  }
  
  private func adjustSubclass() {
    self.view.backgroundColor = AppColors.DefaultBackground
    self.title = AppStrings.PaletteVCTile
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.estimatedRowHeight = 80.0
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.backgroundColor = AppColors.DefaultBackground
    self.tableView.separatorColor = UIColor.clearColor()
    // TODO: adjust separator insets
  }
  
  
  // MARK: UITableviewDataSource
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let colorPallete: ColorPalette = self.debugPaletteManager.managedColorPalettes[indexPath.section]
    var cell = tableView.dequeueReusableCellWithIdentifier(ExpandingTableViewCell.expandingIdentifier)
    if cell == nil {
      cell = SimpleExpandingCell(style: .Default,
                                 reuseIdentifier: ExpandingTableViewCell.expandingIdentifier,
                                 palette: colorPallete)
    }
    
    return cell!
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.debugPaletteManager.paletteCount()
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if let existingView: UIView = tableView.headerViewForSection(section) {
      return existingView
    }
    else {
      let header: UITableViewHeaderFooterView = UITableViewHeaderFooterView(reuseIdentifier: "Test")
      let simpleHeader = SimpleHeaderView(withTitle: self.debugPaletteManager.paletteName(atIndex: section))
      header.contentView.addSubview(simpleHeader)
      
      simpleHeader.snp_makeConstraints(closure: { (make) in
        make.edges.equalTo(header)
      })
      
      return header
    }
  }
  
  func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 40.0
  }
  
  
  // MARK: - UITableViewDelegate
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //TODO: - needs reimplementation for smooth animations, i think..
    tableView.reloadData()
  }
  
  
  // MARK: - Other
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  
  // MARK: - Lazy Inits
  internal lazy var tableView: UITableView = {
    let tableView: UITableView = UITableView(frame: CGRectZero, style: .Plain)
    return tableView
  }()
}