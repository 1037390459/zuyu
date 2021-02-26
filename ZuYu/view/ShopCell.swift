//
//  ShopCell.swift
//  ZuYu
//
//  Created by million on 2020/7/12.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {
    
    @IBOutlet weak var iconImgV: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var distanceLbl: UILabel!
    
    @IBOutlet weak var scoreLbl: UILabel!
    
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var countLbl: UILabel!
    
    @IBOutlet weak var zanBtn: UIButton!
    
    var model : StoreList.Store? {
        didSet {
            nameLbl.text = model?.storeName
            distanceLbl.text = "\(model?.storeDistance ?? "0")m"
            scoreLbl.text = "环境\(model?.ambientScore ?? 0)分 | 服务\(model?.serviceScore ?? 0)分"
            priceLbl.text = "¥\(model?.minPrice ?? 0)起"
            countLbl.text = "\(model?.orderCount ?? 0)单"
            zanBtn.setTitle("\(model?.collectCount ?? 0)", for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
