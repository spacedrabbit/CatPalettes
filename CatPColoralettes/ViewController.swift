//
//  ViewController.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: BasePaletteViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.redColor()
    
    let testView: SingleColorEditView = SingleColorEditView(withColor: nil)
    self.view.addSubview(testView)
    
    testView.snp_makeConstraints { (make) in
      make.left.right.equalTo(self.view)
      make.top.equalTo(100.0)
      make.height.lessThanOrEqualTo(100.0)
    }
    
    let secondTestView: SingleColorEditView = SingleColorEditView(withColor: UIColor.blueColor())
    self.view.addSubview(secondTestView)
    
    secondTestView.snp_makeConstraints { (make) in
      make.left.right.equalTo(self.view)
      make.top.equalTo(testView.snp_bottom).offset(16.0)
      make.height.lessThanOrEqualTo(100.0)
    }
  }

  override func paletteButtonTapped() {
    self.showMenu(nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

