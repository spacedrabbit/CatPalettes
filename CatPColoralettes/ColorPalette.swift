//
//  ColorPalette.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/19/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Equatable
extension ColorPalette: Equatable {
}
func ==(lhs: ColorPalette, rhs: ColorPalette) -> Bool {
  let colorsMatch = lhs.paletteColors.elementsEqual(rhs.paletteColors)
  let numberOfElementsMatch = lhs.paletteColors.count == rhs.paletteColors.count
  return colorsMatch && numberOfElementsMatch
}


// MARK: -
internal struct ColorPalette: Hashable {
  internal var paletteName: String
  internal var paletteColors: [UIColor]
  private let dateCreated: NSDate
  
  
  // MARK: - Initialization
  internal init(withDictionary dict: [String : AnyObject]) throws {
   
    guard
      let pData: [String : AnyObject] = dict[AppKeys.Data] as? [String : AnyObject]
    else {
      throw NSError(domain: "Invalid Root Node in Dictionary", code: 000, userInfo: dict)
    }
    
    guard
      let pName: String = pData[AppKeys.Name] as? String,
      let colorInfo: [[String : AnyObject]] = pData[AppKeys.Colors] as? [[String : AnyObject]]
    else {
      throw NSError(domain: "Invalid Dictionary", code: 001, userInfo: dict)
    }
    
    var colors: [UIColor] = []
    for colorNode in colorInfo {
      guard
        let red: NSNumber = colorNode[AppKeys.Red] as? NSNumber,
        let blue: NSNumber = colorNode[AppKeys.Blue] as? NSNumber,
        let green: NSNumber = colorNode[AppKeys.Green] as? NSNumber
      else {
        throw NSError(domain: "Invalid Color Dictionary", code: 002, userInfo: colorNode)
      }
      
      colors.append(UIColor(red: CGFloat(red.floatValue), green: CGFloat(green.floatValue), blue: CGFloat(blue.floatValue), alpha: 1.0))
    }
    
    self.paletteName = pName
    self.paletteColors = colors
    self.dateCreated = NSDate()
  }
  
  internal init(name: String, colors: [UIColor]?) {
    self.paletteName = name
    self.paletteColors = colors ?? []
    self.dateCreated = NSDate()
  }
  
  
  // MARK: - Hashable
  internal var hashValue: Int {
    return paletteName.hashValue ^ dateCreated.hashValue
  }
  
  
  // MARK: - Storage
  internal func toDictionary() -> [String : AnyObject] {
    
    var returnDictionary: [String : AnyObject] = [:]
    var colorContainer: [AnyObject] = []

    for color in self.paletteColors {
      let colorComponets = rgbComponentsFrom(color)
      let dictVal = [
        AppKeys.Red : colorComponets.r,
        AppKeys.Green : colorComponets.g,
        AppKeys.Blue : colorComponets.b
      ]
      
      colorContainer.append(dictVal)
    }
    
    returnDictionary[AppKeys.Data] = [
      AppKeys.Name : self.paletteName,
      AppKeys.Colors : colorContainer
    ]
    
    return returnDictionary
  }
  
}
