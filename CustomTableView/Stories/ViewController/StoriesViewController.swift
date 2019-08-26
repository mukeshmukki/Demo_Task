//
//  ViewController.swift
//  CustomTableView
//
//  Created by pavithra.m on 12/08/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {
  
  let tableView = UITableView()
  private var storyModel = StoriesViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    setUpUI()
  }
  
  func setUpUI(){
    let refreshItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshButtonTap(sender:)))
    self.navigationItem.rightBarButtonItem = refreshItem
    
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    tableView.register(StoriesTableViewCell.self, forCellReuseIdentifier: Constants.storiesCellId)
    tableView.addSubview(refreshControl)
    setUpCallBackFunctions()
  }
  
  lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action:
      #selector(refreshStory(_:)),
                             for: UIControl.Event.valueChanged)
    refreshControl.tintColor = UIColor.blue
    return refreshControl
  }()
  
  @objc func refreshStory(_ refreshControl: UIRefreshControl) {
    storyModel.getStoryDetail()
  }
  
  func setUpCallBackFunctions(){
    storyModel.reloadTable = { [weak self] in
      DispatchQueue.main.async {
        self!.navigationController?.navigationBar.topItem?.title = self!.storyModel.title
        self?.tableView.reloadData()
        self?.refreshControl.endRefreshing()
        ActivityIndicator.sharedIndicator.hideActivityIndicator(onView: self!.view)
      }
    }
    storyModel.reloadRow = { [weak self] path in
      DispatchQueue.main.async {
        self?.tableView.reloadRows(at: [path], with: .none)
      }
    }
    storyModel.alertOnError = { [weak self] errorMessage in
      ActivityIndicator.sharedIndicator.hideActivityIndicator(onView: self!.view)
      self?.showErrorAlert(error: errorMessage)
    }
    ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
    storyModel.getStoryDetail()
  }
  
  func showErrorAlert(error: String) {
    let alert = UIAlertController(title:"Error", message:error,preferredStyle:UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title:"OK",style: .cancel,handler: { action in
      
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc func refreshButtonTap(sender: UIButton) {
    ActivityIndicator.sharedIndicator.displayActivityIndicator(onView: view)
    storyModel.getStoryDetail()
  }
}

extension StoriesViewController:UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return storyModel.storyDetailArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.storiesCellId, for: indexPath) as! StoriesTableViewCell
    let details = storyModel.storyDetailArray[indexPath.row]
    cell.tableContent = details
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let details = storyModel.storyDetailArray[indexPath.row]
    let storyDetailVC = storyboard?.instantiateViewController(withIdentifier: "StoryDetail") as! StoryDetailViewController
    storyDetailVC.storyDetail = details
    self.navigationController?.pushViewController(storyDetailVC, animated: false)
  }
}
