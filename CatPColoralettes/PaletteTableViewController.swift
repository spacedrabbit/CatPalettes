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

internal class PaletteTableViewController: UITableViewController {
  
  internal var colorPalletes: [ColorPalette] {
    return [
      ColorPalette(name: "Palette A", colors: [randomColor(), randomColor(), randomColor(), randomColor(), randomColor()]),
      ColorPalette(name: "Palette B", colors: [randomColor(), randomColor(), randomColor(), randomColor()]),
      ColorPalette(name: "Palette C", colors: [randomColor(), randomColor(), randomColor(), randomColor()]),
      ColorPalette(name: "Palette D", colors: [randomColor(), randomColor(), randomColor(), randomColor()]),
    ]
  }
  
  internal var debugPallete: [ColorPalette] {
    return [
      ColorPalette(name: "Debug Primary", colors: [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor()]),
      ColorPalette(name: "Debug Secondary", colors: [UIColor.purpleColor(), UIColor.orangeColor(), UIColor.greenColor()])
    ]
  }
  internal var paletteManager: ExpandingViewGroupManager!
  internal var debugPaletteManager: ExpandingViewGroupManager!
  
  convenience init() {
    self.init(style: .Plain)
  }
  
  override init(style: UITableViewStyle) {
    super.init(style: style)
    
    self.paletteManager = ExpandingViewGroupManager(withPalettes: self.colorPalletes)
    self.debugPaletteManager = ExpandingViewGroupManager(withPalettes: self.debugPallete)
    self.adjustSubclass()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func adjustSubclass() {
    self.tableView.estimatedRowHeight = 80.0
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.backgroundColor = AppColors.DefaultBackground
    self.tableView.separatorColor = UIColor.clearColor()
    self.tableView.separatorInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 0.0, right: 0.0)
//    self.tableView.estimatedSectionHeaderHeight = 40.0
    self.title = "Palettes"
  }
  
  // MARK: UITableviewDataSource
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let colorPallete: ColorPalette = self.debugPaletteManager.managedColorPalettes[indexPath.section]
    
    var cell = tableView.dequeueReusableCellWithIdentifier(ExpandingTableViewCell.expandingIdentifier)
    if cell == nil {
      cell = SimpleExpandingCell(style: .Default, reuseIdentifier: ExpandingTableViewCell.expandingIdentifier, palette: colorPallete)
    }
    
    return cell!
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.debugPaletteManager.paletteCount()
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //TODO: - needs reimplementation for smooth animations, i think..
    tableView.reloadData()
  }

  
  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
  
  override func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 40.0
  }
  
  // MARK: - Other
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}