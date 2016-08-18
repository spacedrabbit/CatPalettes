//
//  ViewController.swift
//  CatPColoralettes
//
//  Created by Louis Tur on 8/18/16.
//  Copyright © 2016 catthoughts. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.redColor()
    
    let expanding: ExpandingView = ExpandingView()
    self.view.addSubview(expanding)
    
    expanding.snp_makeConstraints { (make) in
      make.left.right.equalTo(self.view)
      make.top.equalTo(100.0)
      make.height.greaterThanOrEqualTo(20.0)
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

