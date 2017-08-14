//
//  TtNavigationController.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/14.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class TtNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sinaCertified()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func sinaCertified() {
        if ((UserDefaults.standard.bool(forKey: "certified"))) {
            let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
            guard let VC = mainStoryboard.instantiateViewController(withIdentifier: "NewsViewController") as? NewsViewController else {
                return
            }
            self.addChildViewController(VC)
        }
    }
}
