//
//  ViewController.swift
//  CustomTableView
//
//  Created by pavithra.m on 12/08/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var tableDetailArr = [TableObjectClass]()
  let tableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let refreshItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshButtonTap(sender:)))
    self.navigationItem.rightBarButtonItem = refreshItem
    setUpTable()
  }
  
  func setUpTable(){
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    tableView.register(TableViewCell.self, forCellReuseIdentifier: Constants.cellId)
    gettableDetail()
  }
  
  func gettableDetail() {
    API.getInstance.getTableContent() { (error, response) in
      if error == ErrorCode.success {
        let tableDetail = response["tableContent"] as! [String: AnyObject]
        self.tableDetailArr = tableDetail["detail"] as! [TableObjectClass]
        DispatchQueue.main.async {
          self.navigationController?.navigationBar.topItem?.title = tableDetail["title"] as? String
          self.tableView.reloadData()
        }
        self.readImage()
      } else {
        let error = response["error"] as? String
        self.showErrorAlert(error: error!)
      }
    }
  }
  
  func readImage(){
    for index in 0...tableDetailArr.count-1{
      let tableContent = tableDetailArr[index]
      if let imageURL = URL(string: tableContent.tableImageURL){
        API.getInstance.getDataFromUrl(url: imageURL){ data,response,error in
          guard let data = data, error == nil else { return () }
          if let image = UIImage(data: data) {
            self.tableDetailArr[index].tableImage = image
            let indexPath = IndexPath(row: index, section: 0)
            DispatchQueue.main.async {
              self.tableView.reloadRows(at: [indexPath], with: .none)
            }
          }
        }
      }
    }
  }
  
  func showErrorAlert(error: String) {
    let alert = UIAlertController(title:"Error", message:error,preferredStyle:UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title:"OK",style: .cancel,handler: { action in
      
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  @objc func refreshButtonTap(sender: UIButton) {
    gettableDetail()
  }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableDetailArr.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as! TableViewCell
    let details = tableDetailArr[indexPath.row]
    cell.tableContent = details
    return cell
  }
}
