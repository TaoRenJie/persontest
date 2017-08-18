//
//  UserDetailModel.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/16.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class UserDetailModel: NSObject {

    // 微博信息内容
    

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    override init() {

    }

    init(dictionary: [String: Any]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
}
