//
//  Constants.swift
//  CustomTableView
//
//  Created by pavithra.m on 12/08/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

enum ErrorCode: Int {
  case success = 200
  case failure = 1001
  case unAuthorizedUser = 401  // You are not authorized to view the resource
  case forbidden = 403         //Accessing the resource you were trying to reach is forbidden
  case siteNotReach = 404      // The resource you were trying to reach is not found
}

class Constants: NSObject {
  static var urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
  static var storiesCellId = "storiesCellId"
  static var title = "title"
}
