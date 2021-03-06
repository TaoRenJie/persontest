//
//  Model.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/4.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class Model: NSObject {
    // 模型中用到的属性

    // 微博信息内容
    var id: Int64 = 0
    var text: String = ""
    var name: String = ""
    var headImageString: String = ""
    var pictureArray: Array<String> = []
    var bigPictureArray: Array<String> = []
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    override init() {

    }

    init(dictionary: [String: Any]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
}
