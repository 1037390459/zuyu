//
//  PaiWeiCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/9.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class PaiWeiCell: UITableViewCell {
    
    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var stateView: UIView!
    
    @IBOutlet weak var stateImgV: UIImageView!
    
    @IBOutlet weak var numberLbl: UILabel!
    
    @IBOutlet weak var infoLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        mContentView.addShadow(ofColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.03), radius: 10, offset: CGSize.init(width: 0, height: 2), opacity: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
