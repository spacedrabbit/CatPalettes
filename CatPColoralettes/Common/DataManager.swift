//
//  DataManager.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/25/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import Foundation
import UIKit

internal class DataManager {
  
  internal static let folderName: String = "ColorPalette Data"
  
  static let shared: DataManager = DataManager()
  private var fileManager: NSFileManager = NSFileManager()
  private init() { }
  
  internal func storePalettes(palettes: [ColorPalette]) {
    
    let original: [ColorPalette] = palettes
    var container: [AnyObject] = []
    for palette in original {
      container.append(palette.toDictionary())
    }
    
    
    do {
  
      let dataEncoded: NSData = try NSJSONSerialization.dataWithJSONObject(container, options: [])
      if let base64ed: NSData = dataEncoded.base64EncodedDataWithOptions([]) {
        if let destinationPath: NSURL = self.fileManager.URLsForDirectory(.LibraryDirectory, inDomains: .UserDomainMask).first {
          let newURL = NSURL(fileURLWithPath: "\(DataManager.folderName)/", relativeToURL: destinationPath)
          
          do {
            try self.fileManager.createDirectoryAtURL(newURL, withIntermediateDirectories: true, attributes: nil)
          } catch {
            print("file manager threw")
          }
         
          // TODO: create file
          // TODO: save/store file
          self.fileManager.createFileAtPath("\(newURL.absoluteString)colorInfo.txt", contents: base64ed, attributes: nil)
          
          
        }
      }
    }
    catch {
      
    }
    
    
    
  }
  
  internal func retrievePalettes() -> [ColorPalette]? {
    
    return nil
  }
  
}