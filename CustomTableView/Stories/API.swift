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
  
  func callAPI(urlString:String!,completionHandler:@escaping(_ errorCode:ErrorCode, _ response:[String:AnyObject])->()) {
    
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
  
  func getStoryDetails(completionHandler:@escaping(_ errorCode:ErrorCode, _ response: [String:AnyObject]) -> ()) {
    
    let urlString = Constants.urlString
    self.callAPI(urlString: urlString){(errorMessage, jsonData) in
      if errorMessage == ErrorCode.success {
        if let result = jsonData["rows"] {
          let resultArray = result as? NSArray
          var storyDetailArray:[Stories] = []
          var title = String()
          if let titleInfo = jsonData["title"] as? String{
            title = titleInfo
          }
          for storyInfo in resultArray!
          {
            let storyDetail = Stories()
            if let title = (storyInfo as AnyObject)["title"] as? String{
              storyDetail.tableTitle = title
            }
            if let description = (storyInfo as AnyObject)["description"] as? String{
              storyDetail.tableDescription = description
            }
            if let imageURL = (storyInfo as AnyObject)["imageHref"] as? String{
              storyDetail.tableImageURL = imageURL
            }
            storyDetailArray.append(storyDetail)
          }
          var storyDetails = [String: AnyObject]()
          storyDetails[Constants.title] = title as AnyObject
          storyDetails["detail"] = storyDetailArray as AnyObject
          completionHandler(ErrorCode.success,["tableContent":storyDetails as AnyObject])
        } else {
          completionHandler(ErrorCode.failure, ["error": "Unable to process your request.Try again later" as AnyObject])
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
