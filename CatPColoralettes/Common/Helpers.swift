//
//  Helpers.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/19/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Any helpful functions
internal func randomZeroToOne() -> CGFloat {
  return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
}

internal func randomColor(randomAlpha alphaIsRandom: Bool) -> UIColor {
  let alphaValue = alphaIsRandom ? randomZeroToOne() : 1.0
  return UIColor(red: randomZeroToOne(), green: randomZeroToOne(), blue: randomZeroToOne(), alpha: alphaValue)
}