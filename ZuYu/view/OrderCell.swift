//
//  OrderCell.swift
//  ZuYu
//
//  Created by million on 2020/7/25.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {
    
    /// 评论回调
    public var commentClosure : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func comment(_ sender: Any) {
        commentClosure?()
    }
    
}
