//
//  StoryDetailViewController.swift
//  CustomTableView
//
//  Created by pavithra.m on 26/08/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class StoryDetailViewController: UIViewController {
  
  var storyDetail = Stories()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setUpUI()
  }
  
  func setUpUI(){
    tableTitle.text = storyDetail.tableTitle
    tableImage.image = storyDetail.tableImage
    tableDescription.text = storyDetail.tableDescription
    
    view.addSubview(tableTitle)
    view.addSubview(tableDescription)
    view.addSubview(tableImage)
    
    let leadingTitleConstraint = NSLayoutConstraint(item: tableTitle, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: Constants.spacing)
    let trailingTitleConstraint = NSLayoutConstraint(item: tableTitle, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -Constants.spacing)
    let topTitleConstraint = NSLayoutConstraint(item: tableTitle, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: Constants.spacing)
    view.addConstraints([leadingTitleConstraint,trailingTitleConstraint,topTitleConstraint])
    
    let leadingImageConstraint = NSLayoutConstraint(item: tableImage, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: Constants.spacing)
    let trailingImageConstraint = NSLayoutConstraint(item: tableImage, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -Constants.spacing)
    let topImageConstraint = NSLayoutConstraint(item: tableImage, attribute: .top, relatedBy: .equal, toItem: tableTitle, attribute: .bottom, multiplier: 1, constant: Constants.spacing)
    view.addConstraints([leadingImageConstraint,trailingImageConstraint,topImageConstraint])
    
    let leadingDescConstraint = NSLayoutConstraint(item: tableDescription, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: Constants.spacing)
    let trailingDescConstraint = NSLayoutConstraint(item: tableDescription, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -Constants.spacing)
    let topDescConstraint = NSLayoutConstraint(item: tableDescription, attribute: .top, relatedBy: .equal, toItem: tableImage, attribute: .bottom, multiplier: 1, constant: Constants.spacing)
    view.addConstraints([leadingDescConstraint,trailingDescConstraint,topDescConstraint])
  }
  
  private let tableTitle : UILabel = {
    let titleLbl = UILabel()
    titleLbl.textColor = .black
    titleLbl.font = UIFont.boldSystemFont(ofSize: CGFloat(Constants.titleFont))
    titleLbl.textAlignment = .left
    titleLbl.translatesAutoresizingMaskIntoConstraints = false
    return titleLbl
  }()
  
  private let tableDescription : UILabel = {
    let descriptionLbl = UILabel()
    descriptionLbl.textColor = .gray
    descriptionLbl.font = UIFont.systemFont(ofSize: CGFloat(Constants.paragraphFont))
    descriptionLbl.textAlignment = .left
    descriptionLbl.numberOfLines = 0
    descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
    return descriptionLbl
  }()
  
  private let tableImage : UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFit
    imgView.clipsToBounds = true
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
}
