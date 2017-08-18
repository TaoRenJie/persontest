//
//  NewMainController.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/8.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit
import SwiftyJSON
//"2.00DdB5nFtEuwhCddf9b1bc170GUDFp"
class NewMainController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!

    var access_token = ""



    private var myDataSource: Array<Model> = []
    private var useArray: Array<[String: Any]> = []

    private func loadDataSource() {
        let kUrl = "https://api.weibo.com/2/statuses/user_timeline.json"
        let parameters = [
            "access_token": self.access_token,
            "count": 1,
            "feature":1
        ] as [String : Any]
        NetworkManager.shared.request(requestType: .GET, urlString: kUrl, parameters: parameters as [String : AnyObject]) { (json) in
            let jsonData = JSON(json as AnyObject)
            guard let text: String = jsonData["statuses","text"].string else {
                return
            }
//            var purposeDictionary: [String: Any] = [:]
//            purposeDictionary.updateValue(text, forKey: "text")
//            self.useArray.append(purposeDictionary)

//            guard let dicArray = json?["statuses"] as? [[String : Any]] else{
//                return
//            }
//            var purposeDictionary: [String: Any] = [:]
//            for i in 0..<dicArray.count {
//                let what = dicArray[i]
//                guard let text = what["text"] else {
//                    return
//                }
//                purposeDictionary.updateValue(text, forKey: "text")
//                self.useArray.append(purposeDictionary)
//            }
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
