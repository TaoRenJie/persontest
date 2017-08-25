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
            var pictureArray: Array<String> = []
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
                guard let headImageName = userDictionary["profile_image_url"]?.string else {
                    return
                }
                guard let pictureJson: Array = what["pic_urls"].array else {
                    return
                }
                if pictureJson.count != 0 {
                    for pictureStringJson in pictureJson {
                        guard let pictureString = pictureStringJson["thumbnail_pic"].string else {
                            return
                        }
                        pictureArray.append(pictureString)
                    }
                    purposeDictionary.updateValue(pictureArray, forKey: "pictureArray")
                    pictureArray.removeAll()
                } else {
                    purposeDictionary.updateValue(Array<String>(), forKey: "pictureArray")
                }
                purposeDictionary.updateValue(text, forKey: "text")
                purposeDictionary.updateValue(userName, forKey: "name")
                purposeDictionary.updateValue(headImageName, forKey: "headImageString")
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
        // 不知道有什么用（必须设置这个cell才会内容适应自适应高度）
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    func refreshData() {
        self.myDataSource.removeAll()
        self.loadDataSource()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    //    // MARK: - Table view data source
    // 显示当前xib的高度
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let cell: MyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "maincell") as? MyTableViewCell else {
//            return 0
//        }
//        return cell.frame.size.height
//    }

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section:  Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myDataSource.count
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "maincell") as? MyTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("MyTableViewCell", owner: nil, options: nil)?.last as? MyTableViewCell
        }
        let cellModel: Model = myDataSource[indexPath.row]
        cell?.setData(model: cellModel)
        return cell!
    }
}
