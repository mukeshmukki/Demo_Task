//
//  StoriesViewModel.swift
//  CustomTableView
//
//  Created by pavithra.m on 25/08/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class StoriesViewModel {
  
  var title:String?
  var storyDetailArray = [Stories]()
  var reloadTable: ()->() = { }
  var reloadRow: (IndexPath)->() = { _ in}
  var alertOnError : (String)->() = { _ in}
  
  func getStoryDetail() {
    API.getInstance.getStoryDetails() { (error, response) in
      if error == ErrorCode.success {
        let storyDetail = response["tableContent"] as! [String: AnyObject]
        self.storyDetailArray = storyDetail["detail"] as! [Stories]
        self.title = storyDetail[Constants.title] as? String
        self.reloadTable()
        self.readImage()
      } else {
        //DISPLAYS DYNAMIC ERROR MESSAGE COMING FROM API CLASS
        if let error = response["error"] as? String{
          self.alertOnError(error)
        }
      }
    }
  }
  
  func readImage(){
    for index in 0...storyDetailArray.count-1{
      let tableContent = storyDetailArray[index]
      storyDetailArray[index].tableImage = UIImage(named: "default")
      if let imageURL = URL(string: tableContent.tableImageURL){
        API.getInstance.getDataFromUrl(url: imageURL){ data,response,error in
          guard let data = data, error == nil else { self.storyDetailArray[index].tableImage = UIImage(named: "default")
            return () }
          if let image = UIImage(data: data) {
            self.storyDetailArray[index].tableImage = image
            let indexPath = IndexPath(row: index, section: 0)
            self.reloadRow(indexPath)
          }else{
            self.storyDetailArray[index].tableImage = UIImage(named: "default")
          }
        }
      }else{
        storyDetailArray[index].tableImage = UIImage(named: "default")
      }
    }
  }
}
