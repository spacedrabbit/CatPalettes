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
  
  override init(style: UITableViewStyle) {
    super.init(style: style)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: UITableviewDataSource
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  // MARK: UITableViewDelegate
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
}