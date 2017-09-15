//
//  CommentView.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/9/13.
//  Copyright © 2017年 tt. All rights reserved.
//

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupUI()
//    }

import UIKit

protocol CommentViewDelegate:NSObjectProtocol {
    func reloadData()
}

class CommentView: UIView {
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentView: UIView!

    var weiBoID: Int64 = 0
    var access_token = ""
    weak var delegate:CommentViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        commentTextField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(CommentView.keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        setupUI()
    }

    @IBAction func sendButtonAction(_ sender: UIButton) {
        postData()
        self.delegate?.reloadData()
        UIView.animate(withDuration: 0.5) {
            self.removeFromSuperview()
        }
    }

    private func setupUI() {
        self.frame = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5) {
            self.removeFromSuperview()
        }
    }

    private func postData() {
        let kUrl = "https://api.weibo.com/2/comments/create.json"
        let parameters = [
            "access_token": self.access_token,
            "id": self.weiBoID,
            "comment": self.commentTextField.text ?? String()
            ] as [String : Any]
        NetworkManager.shared.request(requestType: .POST, urlString: kUrl, parameters: parameters as [String : AnyObject]) { (json) in
        }
    }

    func keyBoardWillShow(_ note:NSNotification) {
        let userInfo  = note.userInfo! as NSDictionary
        let keyBoardBounds = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            self.commentView.transform = CGAffineTransform(translationX: 0,y: -deltaY)
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
}
