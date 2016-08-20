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
  internal var paletteManager: ExpandingViewGroupManager!
  
  convenience init() {
    self.init(style: .Plain)
  }
  
  override init(style: UITableViewStyle) {
    super.init(style: style)
    
    self.paletteManager = ExpandingViewGroupManager(withPalettes: self.colorPalletes)
    self.adjustSubclass()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func adjustSubclass() {
    self.tableView.registerClass(SimpleExpandingCell.self, forCellReuseIdentifier: SimpleExpandingCell.cellIdentifier)
    self.tableView.estimatedRowHeight = 45.0
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    self.title = "Palettizer"
  }
  
  // MARK: UITableviewDataSource
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCellWithIdentifier(ExpandingTableViewCell.expandingIdentifier)
    if cell == nil {
      cell = SimpleExpandingCell(style: .Default, reuseIdentifier: ExpandingTableViewCell.expandingIdentifier)
    }
    
    return cell!
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.paletteManager.paletteColorCount(atIndex: section)
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.paletteManager.paletteCount()
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let sectionsToTap = self.paletteManager.indexPathsForPalettes(inSection: indexPath.section)
    sectionsToTap.forEach { (path) in
      let cell = tableView.cellForRowAtIndexPath(path) as! SimpleExpandingCell
      cell.simulateTap()
    }
    
    tableView.reloadData()
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.paletteManager.paletteName(atIndex: section)
  }
}