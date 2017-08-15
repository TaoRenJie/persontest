//
//  NewsViewController.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/3.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController ,ZYColumnViewControllerDelegate {

    @IBOutlet weak var contentScrollView: UIScrollView!
    // 初始化columnVC
    let columnVC = ZYColumnViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray

        // 注意，如果frame 位置，显示出现问题，尝试设置这个属性
        self.automaticallyAdjustsScrollViewInsets = false

        // 注意，arrayTitles 不能为空
        let arrayTitles = ["头条"]
        let arraySpareTitles = ["房产","直播","轻松一刻","独家","社会","手机","数码","酒香","美女","艺术","读书","情感","论坛","博客","NBA","旅游","跑步","影视","政务","本地","汽车","公开课","游戏","独家","时尚","轻松一刻","社会","漫画"]
        self.initColumnVC(arrayTitles, arraySpareTitles, 1)

    }

    private func initColumnVC(_ titles : [String], _ spareTitles : [String] , _ fixCount : Int){

        columnVC.view.frame = CGRect(x: 0, y: 64, width: ZYScreenWidth, height: 40)
        columnVC.arrayTitles = titles
        if spareTitles.count > 0 {
            columnVC.arraySpareTitles = spareTitles
        }
        columnVC.fixedCount = fixCount
        columnVC.delegate = self
        view.addSubview(columnVC.view)
        addChildViewController(columnVC)
        for i in 0..<titles.count {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard let newView = sb.instantiateViewController(withIdentifier: "NewMainController") as? NewMainController else {
                return
            }
            self.addChildViewController(newView)
            newView.view.frame = CGRect(x: self.view.frame.width * CGFloat(i),y: 0,width: self.view.frame.width,height: self.view.frame.height - 64)
            self.contentScrollView.addSubview(newView.view)
        }
        contentScrollView.contentSize = CGSize(width: CGFloat(titles.count) * UIScreen.main.bounds.width, height: 0)
        contentScrollView.isPagingEnabled = true
    }

    func columnViewControllerSetTitle(setTitle: String, index: Int) {

    }

    func columnViewControllerSelectedTitle(selectedTitle: String, index: Int) {
        contentScrollView.setContentOffset(CGPoint(x: CGFloat(index) * contentScrollView.frame.size.width,
                                                   y: contentScrollView.contentOffset.y), animated: true)
    }

    func columnViewControllerTitlesDidChanged(arrayTitles: [String]!, spareTitles: [String]?) {
        for vc in self.childViewControllers {
            vc.willMove(toParentViewController: nil)
            vc.removeFromParentViewController()
        }
        for i in 0..<arrayTitles.count {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            guard let newView = sb.instantiateViewController(withIdentifier: "NewMainController") as? NewMainController else {
                return
            }
            self.addChildViewController(newView)
            newView.view.frame = CGRect(x: self.view.frame.width * CGFloat(i),y: 0,width: self.view.frame.width,height: self.view.frame.height - 64)
            self.contentScrollView.addSubview(newView.view)
        }
        contentScrollView.contentSize = CGSize(width: CGFloat(arrayTitles.count) * UIScreen.main.bounds.width, height: 0)
        contentScrollView.isPagingEnabled = true
    }
}

extension NewsViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        let title = columnVC.arrayTitles[index]
        columnVC.setSelectItem(title: title)
    }
}
