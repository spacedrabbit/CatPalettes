//
//  Helpers.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/19/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Constants
internal struct AppColors {
  internal static let DefaultBackground: UIColor = hexStringToUIColor("3A233E")
  internal static let DefaultTitleText: UIColor = hexStringToUIColor("F6F6F7")
  internal static let DarkGeoBackgroundTheme: UIColor = hexStringToUIColor("95756F")
  internal static let LightGeoBackgroundTheme: UIColor = UIColor(red: (122.0/255.0), green: (93.0/255.0), blue: (125.0/255.0), alpha: 1.0)
  internal static let Clear: UIColor = UIColor.clearColor()
}

internal struct AppFonts {
  internal static let Header: UIFont = UIFont.systemFontOfSize(24.0)
  internal static let SectionTitle: UIFont = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
  internal static let MenuButtonText: UIFont = UIFont.systemFontOfSize(24.0, weight:  UIFontWeightMedium)
}

internal struct AppStrings {
  internal static let PaletteVCTile: String = "Palettes"
  internal static let GradientsTitle: String = "Gradients"
  internal static let ProfileTitle: String = "Profile"
  internal static let SettingsTitle: String = "Settings"
}


// MARK: - Any helpful functions
internal func randomZeroToOne() -> CGFloat {
  return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
}

internal func randomColor(randomAlpha alphaIsRandom: Bool = false) -> UIColor {
  let alphaValue = alphaIsRandom ? randomZeroToOne() : 1.0
  return UIColor(red: randomZeroToOne(), green: randomZeroToOne(), blue: randomZeroToOne(), alpha: alphaValue)
}

internal func hexStringToUIColor(hex: String) -> UIColor {
  var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
  
  if (cString.hasPrefix("#")) {
    cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
  }
  
  if ((cString.characters.count) != 6) {
    return UIColor.grayColor()
  }
  
  var rgbValue:UInt32 = 0
  NSScanner(string: cString).scanHexInt(&rgbValue)
  
  return UIColor(
    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
    alpha: CGFloat(1.0)
  )
}

