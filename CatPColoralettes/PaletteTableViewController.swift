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
  
  convenience init() {
    self.init(style: .Plain)
  }
  
  override init(style: UITableViewStyle) {
    super.init(style: style)
    self.adjustSubclass()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  private func adjustSubclass() {
    self.tableView.registerClass(SimpleExpandingCell.self, forCellReuseIdentifier: SimpleExpandingCell.cellIdentifier)
    self.tableView.estimatedRowHeight = 45.0
    self.tableView.rowHeight = UITableViewAutomaticDimension
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
    return 5
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("Selected Row: \(indexPath.row)")
    tableView.reloadData()
  }
}