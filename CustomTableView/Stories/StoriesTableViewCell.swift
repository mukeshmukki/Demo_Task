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
    
    let leadingTitleConstraint = NSLayoutConstraint(item: tableTitle, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: Constants.spacing)
    let trailingTitleConstraint = NSLayoutConstraint(item: tableTitle, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -Constants.spacing)
    let topTitleConstraint = NSLayoutConstraint(item: tableTitle, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: Constants.spacing)
    contentView.addConstraints([leadingTitleConstraint,trailingTitleConstraint,topTitleConstraint])
    
    let leadingImageConstraint = NSLayoutConstraint(item: tableImage, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: Constants.spacing)
    let trailingImageConstraint = NSLayoutConstraint(item: tableImage, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -Constants.spacing)
    let topImageConstraint = NSLayoutConstraint(item: tableImage, attribute: .top, relatedBy: .equal, toItem: tableTitle, attribute: .bottom, multiplier: 1, constant: Constants.spacing)
    contentView.addConstraints([leadingImageConstraint,trailingImageConstraint,topImageConstraint])
    
    let leadingDescConstraint = NSLayoutConstraint(item: tableDescription, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: Constants.spacing)
    let trailingDescConstraint = NSLayoutConstraint(item: tableDescription, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -Constants.spacing)
    let topDescConstraint = NSLayoutConstraint(item: tableDescription, attribute: .top, relatedBy: .equal, toItem: tableImage, attribute: .bottom, multiplier: 1, constant: Constants.spacing)
    let bottomDescConstraint = NSLayoutConstraint(item: tableDescription, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -Constants.spacing)
    contentView.addConstraints([leadingDescConstraint,trailingDescConstraint,topDescConstraint, bottomDescConstraint])

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
