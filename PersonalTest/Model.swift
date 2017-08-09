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
    var id: Any = ""
    var opt_name: String = ""
    var priority: Any = ""
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }

    override init() {

    }

    init(dictionary: [String: Any]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
}
