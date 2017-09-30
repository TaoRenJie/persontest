//
//  WeiBoImageView.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/9/28.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class WeiBoImageView: UIImageView  {

    var bigPictureUrl: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init() {
        self.init(frame: CGRect.zero)
    }
}
