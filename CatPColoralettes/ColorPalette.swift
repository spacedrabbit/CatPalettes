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
      let pData: [String : AnyObject] = dict["data"] as? [String : AnyObject]
    else {
      throw NSError(domain: "Invalid Root Node in Dictionary", code: 000, userInfo: dict)
    }
    
    guard
      let pName: String = pData["name"] as? String,
      let colorInfo: [[String : AnyObject]] = pData["colors"] as? [[String : AnyObject]]
    else {
      throw NSError(domain: "Invalid Dictionary", code: 001, userInfo: dict)
    }
    
    var colors: [UIColor] = []
    for colorNode in colorInfo {
      guard
        let red: NSNumber = colorNode["red"] as? NSNumber,
        let blue: NSNumber = colorNode["blue"] as? NSNumber,
        let green: NSNumber = colorNode["green"] as? NSNumber
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
    var container: [AnyObject] = []

    for color in self.paletteColors {
      let colorComponets = rgbComponentsFrom(color)
      let dictVal = [
        "red" : colorComponets.r,
        "green" : colorComponets.g,
        "blue" : colorComponets.b
      ]
      
      container.append(dictVal)
    }
    
    returnDictionary["data"] = [
      "name" : self.paletteName,
      "colors" : container
    ]
    
    return returnDictionary
  }
  
}
