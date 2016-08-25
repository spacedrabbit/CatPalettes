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
import RESideMenu

internal class PaletteViewController: BasePaletteViewController, UITableViewDelegate, UITableViewDataSource, FloatingButtonDelegate {
  
  // ---------------------------------------------------------------- //
  // MARK: - Instance Vars
  
  // Internal
  internal var paletteManager: ExpandingViewGroupManager!
  internal var debugPaletteManager: ExpandingViewGroupManager!
  internal var floatingPlusButton: FloatingButton = FloatingButton(withAction: .Plus)
  
  // Private
  private var floatingPlusButtonBottomConstraint: Constraint?
  private let visibleButtonOffset: CGFloat = -(40.0 + (FloatingButton.LargeButtonSize * 0.5))
  private let hiddenButtonOffset: CGFloat = 40.0 + (FloatingButton.LargeButtonSize * 0.5)
  private var offsetAtStartOfScroll: CGFloat = 0.0
  private var offsetAtEndOfScroll: CGFloat = 0.0
  
  private var lastDrawUpdate: NSDate = NSDate()
  private var timeSinceLastDrawUpdate: NSTimeInterval = 0.0
  
  private var frameCheckToken: dispatch_once_t = 0
  private var originalFloatingButtonFrame: CGRect = CGRectZero
  
  // Calculated
  internal var debugPallete: [ColorPalette] {
    return [
      ColorPalette(name: "Debug Primary", colors: [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor()]),
      ColorPalette(name: "Debug Secondary", colors: [UIColor.purpleColor(), UIColor.orangeColor(), UIColor.greenColor()]),
      ColorPalette(name: "Debug Long", colors: [UIColor.redColor(), UIColor.blueColor(), UIColor.yellowColor(),
                                                UIColor.purpleColor(), UIColor.orangeColor(), UIColor.greenColor()])
    ]
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.debugPaletteManager = ExpandingViewGroupManager(withPalettes: self.debugPallete)
    
    self.setupViewHierarchy()
    self.configureConstraints()
    self.adjustSubclass()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    dispatch_once(&frameCheckToken) {
      // keep a record of the original position for it to return to later
      self.originalFloatingButtonFrame = self.floatingPlusButton.frame
    }
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Setup
  private func configureConstraints() {
    self.tableView.snp_makeConstraints { (make) in
      make.size.equalTo(self.view.snp_size)
      make.edges.equalTo(self.view)
    }
    
    self.floatingPlusButton.snp_makeConstraints { (make) in
      self.floatingPlusButtonBottomConstraint = make.bottom.equalTo(self.view).offset(self.visibleButtonOffset).constraint
      make.centerX.equalTo(self.view)
    }

  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(self.tableView)
    self.view.addSubview(floatingPlusButton)
    
    floatingPlusButton.delegate = self
    // TODO: not really sure why the offset isn't taking the tableTitleView into account on first load, fix later
//    self.tableView.tableHeaderView = self.tableTitleView
  }
  
  private func adjustSubclass() {
    self.view.backgroundColor = AppColors.LightGeoBackgroundTheme
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.estimatedRowHeight = 80.0
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.backgroundColor = AppColors.LightGeoBackgroundTheme
    self.tableView.separatorColor = AppColors.Clear
    // TODO: adjust separator insets
  }
  
  override func paletteButtonTapped() {
    self.showMenu(nil)
  }
  
  // ---------------------------------------------------------------- //
  // MARK: UITableviewDataSource
  internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let colorPallete: ColorPalette = self.debugPaletteManager.managedColorPalettes[indexPath.section]
    var cell = tableView.dequeueReusableCellWithIdentifier(ExpandingTableViewCell.expandingIdentifier)
    if cell == nil {
      cell = SimpleExpandingCell(style: .Default,
                                 reuseIdentifier: ExpandingTableViewCell.expandingIdentifier,
                                 palette: colorPallete)
    }
    
    return cell!
  }
  
  internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.debugPaletteManager.paletteCount()
  }
  
  internal func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
  
  internal func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
    return 40.0
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - UITableViewDelegate
  internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // TODO: there is a leak here, every subsequent call adds ~1MiB at the moment. Something related to CFData but likely its with the pod
    //    selectedCell.simulateTap()
    let selectedCell: SimpleExpandingCell = tableView.cellForRowAtIndexPath(indexPath) as! SimpleExpandingCell
    let destinationVC: PaletteSelectionViewController = PaletteSelectionViewController(withColorPalette: selectedCell.palette)
    self.navigationController?.pushViewController(destinationVC, animated: true)
//    self.tableView.reloadData()
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Scrolling Delegate
  internal func scrollViewDidScroll(scrollView: UIScrollView) {
    
    if self.timeSinceLastDrawUpdate >=  0.1 {

    }
    else {
      // note: tried adding in a time limit to see if that was what was causing the flashing, but it seems as though its
      // an issue with snapkit updating itself
      // but really, it doesn't appear to be a problem with how often its called... as setting the frame directly works well
      let now = NSDate()
      let timeSinceThen = now.timeIntervalSinceDate(self.lastDrawUpdate)
      print("Time since then: \(timeSinceThen)")
      self.timeSinceLastDrawUpdate = timeSinceThen
      self.lastDrawUpdate = now
    }
    
  }
  
  internal func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    self.offsetAtStartOfScroll = scrollView.contentOffset.y
  }

  internal func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.offsetAtEndOfScroll = scrollView.contentOffset.y
  }
  
  internal func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    print("Velocity ending: \(velocity)") // pts/sec I think... negative indicates scrolling from bottom -> top
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Floating Button Delegate
  internal func didTapFloatingButton(withAction action: FloatingButtonAction) {
   let dtvc = PaletteSelectionViewController()
    self.navigationController?.pushViewController(dtvc, animated: true)
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Actions

  
  // ---------------------------------------------------------------- //
  // MARK: - Other
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  
  // ---------------------------------------------------------------- //
  // MARK: - Lazy Inits
  internal lazy var tableView: UITableView = {
    let tableView: UITableView = UITableView(frame: CGRectZero, style: .Plain)
    tableView.tableHeaderView = SimpleTableTitleView(withTitle: AppStrings.PaletteVCTile)
    return tableView
  }()
  
  internal lazy var tableTitleView: SimpleTableTitleView = SimpleTableTitleView(withTitle: AppStrings.PaletteVCTile)
}