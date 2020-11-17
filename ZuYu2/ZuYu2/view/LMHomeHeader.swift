//
//  LMHomeHeader.swift
//  ZuYu2
//
//  Created by million on 2020/8/20.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import MarqueeLabel

class LMHomeHeader: UICollectionReusableView {
    
    @IBOutlet weak var xmyjLbl: UILabel!
    
    @IBOutlet weak var skyjLbl: UILabel!
    
    @IBOutlet weak var xcyjLbl: UILabel!
    
    @IBOutlet weak var xzhyLbl: UILabel!
    
    @IBOutlet weak var spyjLbl: UILabel!
    
    @IBOutlet weak var jdkfLbl: UILabel!
    
    @IBOutlet weak var krslLbl: UILabel!
    
    @IBOutlet weak var kdjjLbl: UILabel!
    
    @IBOutlet weak var notificationLbl: MarqueeLabel!
    
    var model : AchievementsBean? {
        didSet {
            xmyjLbl.text = "\(model?.xmyj ?? 0)"
            skyjLbl.text = "\(model?.skyj ?? 0)"
            xcyjLbl.text = "\(model?.xcyj ?? 0)"
            xzhyLbl.text = "\(model?.xzhy ?? 0)"
            spyjLbl.text = "\(model?.spyj ?? 0)"
            jdkfLbl.text = "\(model?.jdkf ?? 0)"
            krslLbl.text = "\(model?.krsl ?? 0)"
            kdjjLbl.text = "\(model?.kdjj ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
