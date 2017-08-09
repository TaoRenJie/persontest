//
//  UserModel.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/9.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class UserModel: NSObject{

    var access_token: String?
    var remind_in: Any?
    var expires_in: Any?
    var uid: Any?

    //单例
    static let shared = UserModel()

    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    override init() {

    }

    init(dictionary: [String: Any]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }

}
