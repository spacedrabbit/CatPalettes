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

internal class SimpleExpandingCell: UITableViewCell {
  let expansionView = ExpandingView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .None

    self.contentView.addSubview(expansionView)
    
    expansionView.snp_makeConstraints { (make) in
      make.top.bottom.equalTo(self.contentView).priority(990.0)
      make.left.right.width.equalTo(self.contentView)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

}



internal class PaletteTableViewController: UITableViewController {
  
  convenience init() {
    self.init(style: .Plain)
  }
  
  override init(style: UITableViewStyle) {
    super.init(style: style)
    
    self.tableView.registerClass(SimpleExpandingCell.self, forCellReuseIdentifier: ExpandingTableViewCell.expandingIdentifier)
    self.tableView.estimatedRowHeight = 45.0
    self.tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
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
    return 3
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }
}