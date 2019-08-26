//
//  ActivityIndicator.swift
//  CustomTableView
//
//  Created by pavithra.m on 26/08/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ActivityIndicator {
  
  static let sharedIndicator = ActivityIndicator()
  private var spinnerView = UIView()
  
  func displayActivityIndicator(onView : UIView) {
    spinnerView = UIView.init(frame: onView.bounds)
    spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    let ai = UIActivityIndicatorView.init(style: .whiteLarge)
    ai.startAnimating()
    ai.center = spinnerView.center
    
    DispatchQueue.main.async { [weak self] in
      guard let _self = self else { return }
      _self.spinnerView.addSubview(ai)
      onView.addSubview(_self.spinnerView)
      onView.window?.isUserInteractionEnabled = false
    }
    
  }
  
  func hideActivityIndicator(onView : UIView) {
    DispatchQueue.main.async {[weak self] in
      guard let _self = self else { return }
      _self.spinnerView.removeFromSuperview()
      onView.window?.isUserInteractionEnabled = true
    }
  }
  
}
