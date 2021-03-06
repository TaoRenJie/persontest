//
//  MainTableViewController.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/4.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let kUrl = "http://apiv2.yangkeduo.com/operation/15/groups"
    let parameters = [
        "opt_type": 1,
        "size" : 5,
        "offset" : 5
    ]

    private var myDataSource: Array<Model> = []
    private var useArray: Array<[String: Any]> = []

    private func loadDataSource() {
        NetworkManager.shared.request(requestType: .GET, urlString: kUrl, parameters: parameters as [String : AnyObject]) { (json) in
            guard let dicArray = json?["opt_infos"] as? [[String : Any]] else{
                return
            }
            var purposeDictionary: [String: Any] = [:]
            for i in 0..<dicArray.count {
                let what = dicArray[i]
                guard let id = what["id"] else {
                    return
                }
                guard let opt_name = what["opt_name"] else {
                    return
                }
                guard let priority = what["priority"] else {
                    return
                }
                purposeDictionary.updateValue(id, forKey: "id")
                purposeDictionary.updateValue(opt_name, forKey: "opt_name")
                purposeDictionary.updateValue(priority, forKey: "priority")
                self.useArray.append(purposeDictionary)
            }
            let dataSource: Array<[String: Any]> = self.useArray
            for dictionaryModel in dataSource {
                let model: Model = Model(dictionary: dictionaryModel)
                self.myDataSource.append(model)
            }
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataSource()
        // 注册cell
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "id")
    }

//    // MARK: - Table view data source
//
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:  Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myDataSource.count
    }


//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "id") as? MyTableViewCell else {
//            return UITableViewCell()
//        }
//        let cellModel: Model = myDataSource[indexPath.row]
//        cell.setData(model: cellModel)
//        return cell
//    }
}
