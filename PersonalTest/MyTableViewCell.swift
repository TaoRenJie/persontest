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
    }

    func setupUI() {
        headImageView.layer.masksToBounds = true
        headImageView.layer.cornerRadius = headImageView.frame.height / 2
    }
}
