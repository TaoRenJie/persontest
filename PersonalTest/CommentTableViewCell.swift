//
//  CommentTableViewCell.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/9/12.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(model: CommentModel) {
        self.dateLabel.text = model.created_at
        self.commentTextLabel.text = model.text
        self.nameLabel.text = model.userName
        guard let url = URL(string: model.headImageName) else {
            return
        }
        self.headImage.setImageWith(url)
    }
}
