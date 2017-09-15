//
//  CommentModel.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/9/12.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class CommentModel: NSObject {

    // 模型中用到的属性

    // 评论cell中的内容
   	// 评论创建时间
    var created_at: String = ""
    // 	评论的ID
    var id: Int64 = 0
    // 	评论的内容
    var text: String = ""
    // 	评论的来源
    var source: String = ""
    // 	评论的MID
    var mid: String = ""
    // 	字符串型的评论ID
    var idstr: String = ""
    var userName: String = ""
    var headImageName: String = ""

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    override init() {

    }

    init(dictionary: [String: Any]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
}
