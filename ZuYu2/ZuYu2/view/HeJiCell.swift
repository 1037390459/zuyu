//
//  HeJiCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/8.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class HeJiCell: UITableViewCell {
    
    @IBOutlet public  weak var totalView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizesSubviews = true
        totalView.addShadow(ofColor: UIColor(red: 0.28, green: 0, blue: 0.05, alpha: 0.06), radius: 16, offset: CGSize.init(width: 0, height: 4), opacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        totalView.layoutIfNeeded()
        totalView.roundCorners([.topLeft, .topRight], radius: 12)
        print(totalView!)
    }
    
}
