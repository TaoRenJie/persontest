//
//  WeiBoContentController.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/9/13.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeiBoContentController: UIViewController ,UITableViewDelegate ,UITableViewDataSource ,CommentViewDelegate ,SetCommentViewDelegate{
    @IBOutlet weak var tableView: UITableView!

    var cellID: Int64 = 0
    var access_token = ""

    private var myDataSource: Array<CommentModel> = []
    private var useArray: Array<[String: Any]> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // 注册cell
        self.tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "commentTableViewCell")
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        loadData()
        let view: UIView = UIView()
        self.tableView.tableFooterView = view
    }

    private func loadData() {
        let kUrl = "https://api.weibo.com/2/comments/show.json"
        let parameters = [
            "access_token": self.access_token,
            "id": self.cellID
            ] as [String : Any]
        NetworkManager.shared.request(requestType: .GET, urlString: kUrl, parameters: parameters as [String : AnyObject]) { (json) in
            let jsonData = JSON(json as AnyObject)
            self.useArray.removeAll()
            guard let jsonData2 = jsonData["comments"].array else {
                return
            }
            var purposeDictionary: [String: Any] = [:]
            for what in jsonData2 {
                guard let text = what["text"].string else {
                    return
                }
                guard let id = what["id"].int64 else {
                    return
                }
                guard let created_at = what["created_at"].string else {
                    return
                }
                guard let source = what["source"].string else {
                    return
                }
                guard let mid = what["mid"].string else {
                    return
                }
                guard let idstr = what["idstr"].string else {
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
                purposeDictionary.updateValue(text, forKey: "text")
                purposeDictionary.updateValue(id, forKey: "id")
                purposeDictionary.updateValue(created_at, forKey: "created_at")
                purposeDictionary.updateValue(mid, forKey: "mid")
                purposeDictionary.updateValue(idstr, forKey: "idstr")
                purposeDictionary.updateValue(source, forKey: "source")
                purposeDictionary.updateValue(userName, forKey: "userName")
                purposeDictionary.updateValue(headImageName, forKey: "headImageName")
                self.useArray.append(purposeDictionary)
            }
            let dataSource: Array<[String: Any]> = self.useArray
            for dictionaryModel in dataSource {
                let model: CommentModel = CommentModel(dictionary: dictionaryModel)
                self.myDataSource.append(model)
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section:  Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "commentTableViewCell") as? CommentTableViewCell else {
            return UITableViewCell()
        }
        let cellModel: CommentModel = myDataSource[indexPath.row]
        cell.setData(model: cellModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view: SetCommentView = Bundle.main.loadNibNamed("SetCommentView", owner: nil, options: nil)?.last as! SetCommentView
        let cellModel: CommentModel = myDataSource[indexPath.row]
        view.weiBoName = cellModel.userName
        view.weiBoText = cellModel.text
        view.commentid = cellModel.id
        view.access_token = self.access_token
        view.delegate = self
        let window = UIApplication.shared.windows[0]
        window.addSubview(view)
        UIView.animate(withDuration: 0.3) {
            view.setTableView.frame = CGRect(x: 0,y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        }
    }

    func reloadData() {
        self.myDataSource.removeAll()
        self.loadData()
        self.tableView.reloadData()
    }

    func reloadSetData() {
        self.myDataSource.removeAll()
        self.loadData()
    }

    @IBAction func commentButtonAction(_ sender: UIButton) {
        let view: CommentView = Bundle.main.loadNibNamed("CommentView", owner: nil, options: nil)?.last as! CommentView
        view.weiBoID = self.cellID
        view.access_token = self.access_token
        view.delegate = self
        let window = UIApplication.shared.windows[0]
        window.addSubview(view)

    }
}
