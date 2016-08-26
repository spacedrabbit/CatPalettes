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
  internal static let LightGray: UIColor = UIColor(red: (120.0/255.0), green: (120.0/255.0), blue: (120.0/255.0), alpha: 1.0)
  internal static let Clear: UIColor = UIColor.clearColor()
}

internal struct AppFonts {
  internal static let Header: UIFont = UIFont.systemFontOfSize(24.0)
  internal static let SectionTitle: UIFont = UIFont.systemFontOfSize(20.0, weight: UIFontWeightMedium)
  internal static let MenuButtonText: UIFont = UIFont.systemFontOfSize(24.0, weight:  UIFontWeightMedium)
  internal static let SingleColorEditingText: UIFont = UIFont.systemFontOfSize(14.0, weight: UIFontWeightBold)
}

internal struct AppStrings {
  internal static let PaletteVCTile: String = "Palettes"
  internal static let GradientsTitle: String = "Gradients"
  internal static let ProfileTitle: String = "Profile"
  internal static let SettingsTitle: String = "Settings"
}

internal struct AppKeys {
  internal static let Data: String = "data"
  internal static let Name: String = "name"
  internal static let Colors: String = "colors"
  internal static let Red: String = "red"
  internal static let Green: String = "green"
  internal static let Blue: String = "blue"
  
  internal static let Encoded: String = "encoded"
}

internal enum AppMenuButton: Int {
  case Palette, Gradient, Settings, Profile
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

internal func rgbComponentsFrom(color: UIColor) -> (r: CGFloat, g: CGFloat, b: CGFloat) {
  var redComponent: CGFloat = 0.0,
  blueComponent: CGFloat = 0.0,
  greenComponent: CGFloat = 0.0,
  alphaComponent: CGFloat = 0.0
  
  color.getRed(&redComponent, green: &greenComponent, blue: &blueComponent, alpha: &alphaComponent)
  
  let redValueRGB = redComponent * 255.0
  let greenValueRGB = greenComponent * 255.0
  let blueValueRGB = blueComponent * 255.0
  
  return (redValueRGB, greenValueRGB, blueValueRGB)
}

internal func hexValueFrom(color: UIColor) -> (String) {
  let (red, green, blue) = rgbComponentsFrom(color)
  let redValueHex = String(UInt32(red), radix: 16, uppercase: true)
  let greenValueHex = String(UInt32(green), radix: 16, uppercase: true)
  let blueValueHex = String(UInt32(blue), radix: 16, uppercase: true)
  
  return "\(redValueHex)\(greenValueHex)\(blueValueHex)"
}

extension Double {
  /// Rounds the double to decimal places value
  func roundToPlaces(places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return round(self * divisor) / divisor
  }
}
