//
//  ColorPalette.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/19/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

extension ColorPalette: Equatable {
}
func ==(lhs: ColorPalette, rhs: ColorPalette) -> Bool {
  let colorsMatch = lhs.paletteColors.elementsEqual(rhs.paletteColors)
  let numberOfElementsMatch = lhs.paletteColors.count == rhs.paletteColors.count
  return colorsMatch && numberOfElementsMatch
}

internal struct ColorPalette: Hashable {
  internal var paletteName: String
  internal var paletteColors: [UIColor]
  private let dateCreated: NSDate
  
  internal init(name: String, colors: [UIColor]?) {
    self.paletteName = name
    self.paletteColors = colors ?? []
    self.dateCreated = NSDate()
  }
  
  internal var hashValue: Int {
    return paletteName.hashValue ^ dateCreated.hashValue
  }
}
