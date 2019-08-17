//
//  TableViewCell.swift
//  CustomTableView
//
//  Created by pavithra.m on 13/08/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {
  
  var tableContent : Stories? {
    didSet {
      tableImage.image = tableContent?.tableImage
      tableTitle.text = tableContent?.tableTitle
      tableDescription.text = tableContent?.tableDescription
    }
  }
  
  private let tableTitle : UILabel = {
    let titleLbl = UILabel()
    titleLbl.textColor = .black
    titleLbl.font = UIFont.boldSystemFont(ofSize: 16)
    titleLbl.textAlignment = .left
    titleLbl.translatesAutoresizingMaskIntoConstraints = false
    return titleLbl
  }()
  
  private let tableDescription : UILabel = {
    let descriptionLbl = UILabel()
    descriptionLbl.textColor = .gray
    descriptionLbl.font = UIFont.systemFont(ofSize: 14)
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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(tableTitle)
    contentView.addSubview(tableDescription)
    contentView.addSubview(tableImage)
    
    let marginGuide = contentView.layoutMarginsGuide
    tableTitle.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    tableTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    tableTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    
    tableImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    tableImage.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    tableImage.topAnchor.constraint(equalTo: tableTitle.bottomAnchor).isActive = true
    
    tableDescription.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    tableDescription.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    tableDescription.topAnchor.constraint(equalTo: tableImage.bottomAnchor).isActive = true
    tableDescription.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
