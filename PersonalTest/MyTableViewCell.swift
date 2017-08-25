//
//  MyTableViewCell.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/8.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var pictureView: UIView!
    @IBOutlet weak var pictureViewheightConstraint: NSLayoutConstraint!

    var pictureArray: Array<String> = []
    var imageViewHeight: CGFloat = (UIScreen.main.bounds.width - 60)/3
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
        // Configure the view for the selected state
    }

    func setData(model: Model) {
        self.titleLabel.text = model.text
        self.nameLabel.text = model.name
        guard let url = URL(string: model.headImageString) else {
            return
        }
        let data = try! Data(contentsOf: url)
        self.headImageView.image = UIImage(data:data)
        self.pictureArray = model.pictureArray
    }

    func setupUI() {
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = headImageView.frame.height / 2
        if self.pictureArray.count == 0 {
            self.pictureViewheightConstraint.constant = 0
        } else if self.pictureArray.count >= 1 && self.pictureArray.count <= 3 {
            self.pictureViewheightConstraint.constant = 30 + imageViewHeight
            for count in 0 ..< self.pictureArray.count  {
                for pictureName in pictureArray {
                    let imageView = UIImageView()
                    imageView.frame = CGRect(x:CGFloat(15*(count+1) + count * Int(imageViewHeight)), y:15, width:imageViewHeight, height:imageViewHeight)
                    guard let url = URL(string: pictureName) else {
                        return
                    }
                    let data = try! Data(contentsOf: url)
                    imageView.image = UIImage(data:data)
                    self.pictureView?.addSubview(imageView)
                }
            }
        }
    }
}
