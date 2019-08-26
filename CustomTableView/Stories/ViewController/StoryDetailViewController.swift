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
    
    let marginGuide = view.layoutMarginsGuide
    tableTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    tableTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    tableTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    
    tableImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    tableImage.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    tableImage.topAnchor.constraint(equalTo: tableTitle.bottomAnchor).isActive = true
    
    tableDescription.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    tableDescription.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    tableDescription.topAnchor.constraint(equalTo: tableImage.bottomAnchor).isActive = true
  }
  
  private let tableTitle : UILabel = {
    let titleLbl = UILabel()
    titleLbl.textColor = .black
    titleLbl.font = UIFont.boldSystemFont(ofSize: 20)
    titleLbl.textAlignment = .left
    titleLbl.translatesAutoresizingMaskIntoConstraints = false
    return titleLbl
  }()
  
  private let tableDescription : UILabel = {
    let descriptionLbl = UILabel()
    descriptionLbl.textColor = .gray
    descriptionLbl.font = UIFont.systemFont(ofSize: 18)
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
