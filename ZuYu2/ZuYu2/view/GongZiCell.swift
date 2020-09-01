//
//  GongZiCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/8.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class GongZiCell: UITableViewCell {

    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var sureImgV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         mContentView.addShadow(ofColor: Constant.Color.jishiShadow, radius: 16, offset: CGSize.init(width: 0, height: 4), opacity: 1)
        sureImgV.isHidden = Int.random(in: 0...1) == 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
