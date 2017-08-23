//
//  NewMainController.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/8.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewMainController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!

    var access_token = ""
    var refreshControl = UIRefreshControl()

    private var myDataSource: Array<Model> = []
    private var useArray: Array<[String: Any]> = []

    private func loadDataSource() {
        let kUrl = "https://api.weibo.com/2/statuses/user_timeline.json"
        let parameters = [
            "access_token": self.access_token,
            "feature":1
        ] as [String : Any]
        NetworkManager.shared.request(requestType: .GET, urlString: kUrl, parameters: parameters as [String : AnyObject]) { (json) in
            let jsonData = JSON(json as AnyObject)
            self.useArray.removeAll()
            guard let jsonData2 = jsonData["statuses"].array else {
                return
            }
            var purposeDictionary: [String: Any] = [:]
            for what in jsonData2 {
                guard let text = what["text"].string else {
                    return
                }
                guard let userDictionary = what["user"].dictionary else {
                    return
                }
                guard let userName = userDictionary["name"]?.string else {
                    return
                }
                purposeDictionary.updateValue(text, forKey: "text")
                purposeDictionary.updateValue(userName, forKey: "name")
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
        self.navigationController?.navigationBar.isHidden = false
        let gotAccess_token = UserDefaults.standard.value(forKey: "access_token")
        self.access_token = gotAccess_token as! String
        self.loadDataSource()
        // 注册cell
        self.tableView.register(UINib(nibName: "MyTableViewCell", bundle: nil), forCellReuseIdentifier: "maincell")
        self.refreshControl.addTarget(self, action: #selector(refreshData),
                                       for: .valueChanged)
        self.refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.tableView.addSubview(self.refreshControl)
    }

    func refreshData() {
        self.myDataSource.removeAll()
        self.loadDataSource()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    //    // MARK: - Table view data source
    //
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section:  Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myDataSource.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "maincell") as? MyTableViewCell else {
            return UITableViewCell()
        }
        let cellModel: Model = myDataSource[indexPath.row]
        cell.setData(model: cellModel)
        return cell
    }
}
