//
//  API.swift
//  CustomTableView
//
//  Created by pavithra.m on 12/08/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class API:NSObject,URLSessionDelegate{
  
  static let getInstance = API()
  
  func createRequest(urlString:String!,completionHandler:@escaping(_ errorCode:ErrorCode, _ response:[String:AnyObject])->()) {
    
    let requestURL = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!
    let urlRequest = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60)
    let urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    
    urlSession.dataTask(with: urlRequest) { (data, response, error) in
      
      let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
      guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
        print("could not convert data to UTF-8 format")
        return
      }
      do {
        let jsonData = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
        completionHandler(ErrorCode.success,jsonData as! [String: AnyObject])
      } catch {
        completionHandler(ErrorCode.failure, ["error": error.localizedDescription as AnyObject])
      }
      }.resume()
  }
  
  func getTableContent(completionHandler:@escaping(_ errorCode:ErrorCode, _ response: [String:AnyObject]) -> ()) {
    
    let urlString = Constants.urlString
    self.createRequest(urlString: urlString){(errorMessage, jsonData) in
      if errorMessage == ErrorCode.success {
        if let result = jsonData["rows"] {
          let resultArray = result as? NSArray
          var tableDetailArray:[TableObjectClass] = []
          var tableTitle = String()
          if let title = jsonData["title"] as? String{
            tableTitle = title
          }
          for tableInfo in resultArray!
          {
            let tableDetail = TableObjectClass()
            if let title = (tableInfo as AnyObject)["title"] as? String{
              tableDetail.tableTitle = title
            }
            if let description = (tableInfo as AnyObject)["description"] as? String{
              tableDetail.tableDescription = description
            }
            if let imageURL = (tableInfo as AnyObject)["imageHref"] as? String{
              tableDetail.tableImageURL = imageURL
            }
            tableDetailArray.append(tableDetail)
          }
          var tableDetails = [String: AnyObject]()
          tableDetails["title"] = tableTitle as AnyObject
          tableDetails["detail"] = tableDetailArray as AnyObject
          completionHandler(ErrorCode.success,["tableContent":tableDetails as AnyObject])
        } else {
          completionHandler(ErrorCode.failure, ["error": "msg_ErrorInService" as AnyObject])
        }
      } else {
        completionHandler(ErrorCode.failure,["error": jsonData["error"]! as AnyObject])
      }
    }
  }
  
  //GET IMAGE FROM URL
  func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      completion(data, response, error)
      }.resume()
  }
}
