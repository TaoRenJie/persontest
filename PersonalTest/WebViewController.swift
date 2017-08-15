//
//  WebViewController.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/9.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class WebViewController: UIViewController ,UIWebViewDelegate{
    @IBOutlet weak var myWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=2481686703&response_type=code&redirect_uri=http://www.weibo.com"
        guard let url: URL = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url:url)
        self.myWebView.loadRequest(request)
    }

    // 当准备加载某一个页面时,会执行该方法
    // 返回值: true -> 继续加载该页面 false -> 不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 1.获取加载网页的 URL
        guard let url = request.url else {
            return true
        }
        // 2. 获取 URL 中的字符串
        let urlString = url.absoluteString
        // 3.判断该字符串是否包含 code
        guard urlString.contains("code=") else {
            return true
        }
        // 4.将 code 截取出来
        let code = urlString.components(separatedBy: "code=").last
        // 5. 请求 accessToken
        loadAccessToken(code!)
        return false
    }

    func loadAccessToken(_ code : String) {

         loadAccessToken(code: code) { (result) -> (Void) in
            guard result != nil else {

                return
            }
            let userModel: UserModel = UserModel(dictionary: result!)
            UserDefaults.standard.set(userModel.access_token, forKey:"access_token")
            UserDefaults.standard.set(true, forKey:"certified")
            self.performSegue(withIdentifier: "pushSegue", sender: self)
        }
    }

    func loadAccessToken(code: String, finished: @escaping (_ result: [String: Any]?) -> (Void)) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters = ["client_id": "2481686703", "client_secret": "f849eda175f0616b92e998798b891e5c", "grant_type": "authorization_code", "code": code, "redirect_uri": "http://www.weibo.com"]
        NetworkManager.shared.request(requestType: .POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result) in
             finished(result as? [String : Any])
        }
    }
}
