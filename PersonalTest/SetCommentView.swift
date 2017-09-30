//
//  SetCommentView.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/9/19.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol SetCommentViewDelegate:NSObjectProtocol {
    func reloadSetData()
}
class SetCommentView: UIView , UITableViewDelegate, UITableViewDataSource{

    public let setTableView: UITableView = UITableView()
    var weiBoName: String = ""
    var weiBoText: String = ""
    var commentid: Int64 = 0
    var access_token = ""
    weak var delegate:SetCommentViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        self.frame = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        setTableView.frame = CGRect(x: 0,y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        self.addSubview(setTableView)
        setTableView.delegate = self
        setTableView.dataSource = self
        let view: UIView = UIView()
        setTableView.tableFooterView = view
    }

    private func delectWeiBo() {
        let kUrl = "https://api.weibo.com/2/comments/destroy.json"
        let parameters = [
            "access_token": self.access_token,
            "cid": self.commentid
            ] as [String : Any]
        NetworkManager.shared.request(requestType: .POST, urlString: kUrl, parameters: parameters as [String : AnyObject]) { (json) in
            let jsonData = JSON(json as AnyObject)
            print(jsonData)
        }
    }

    func remove() {
        UIView.animate(withDuration: 0.3) {
            self.setTableView.frame = CGRect(x: 0,y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        }
        let time: TimeInterval = 0.2
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.removeFromSuperview()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section:  Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.textAlignment = NSTextAlignment.center
        if indexPath.row == 0 {
            cell.textLabel?.text = weiBoName + ":" + weiBoText
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "回复"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "转发"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "复制"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "删除"
        } else if indexPath.row == 5 {
            cell.textLabel?.text = "取消"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/12
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            delectWeiBo()
            self.delegate?.reloadSetData()
            remove()
        }
        if indexPath.row == 5 {
            remove()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        remove()
    }
}
