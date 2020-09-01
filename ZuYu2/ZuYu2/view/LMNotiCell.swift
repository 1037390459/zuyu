//
//  LMNotiCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/20.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class LMNotiCell: UITableViewCell {
    
    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var mTitleLabel: UILabel!
    
    @IBOutlet weak var mDetailLabel: UILabel!
    
    @IBOutlet weak var mRightDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mImageView.image = UIImage.init(named: "ptxiaoxi")?.redDotImage(CGPoint(x: 0.8, y: 0.1))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
