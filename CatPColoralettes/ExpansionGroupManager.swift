//
//  ExpansionGroupManager.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/19/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation

class ExpandingViewGroupManager {
  internal var managedColorPalettes: [ColorPalette]
  internal (set) var currentIndex: Int = 0
  internal (set) var expanded: Bool = false
  internal var collapsed: Bool { return !expanded }
  
  init(withPalettes palettes: [ColorPalette]) {
    self.managedColorPalettes = palettes
  }
  
  internal func updateIndex(index: Int) {
    self.currentIndex = index
  }
  
  internal func paletteCount() -> Int {
    return managedColorPalettes.count
  }
  
  internal func paletteName(atIndex index: Int) -> String {
    return self.managedColorPalettes[index].paletteName
  }
  
  internal func paletteColorCount(atIndex index: Int) -> Int {
    return self.managedColorPalettes[index].paletteColors.count
  }
  
  internal func paletteInfoRequested(atIndex index: Int) -> ColorPalette {
    return self.managedColorPalettes[index]
  }
  
  internal func indexPathsForPalettes(inSection section: Int) -> [NSIndexPath] {
    var paths: [NSIndexPath] = []
    for i in 0..<self.paletteColorCount(atIndex: section) {
      paths.append(NSIndexPath(forRow: i, inSection: section))
    }
    
    return paths
  }
}
