//
//  PoiCell.swift
//  ZuYu2
//
//  Created by million on 2020/11/7.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class PoiCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var selectBtn: UIButton!
    
    var model : AMapPOI? {
        didSet {
            titleLbl.text = model?.name
            descLbl.text = model?.address
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let img1 = drawRing(size: selectBtn.size, fill: false)
        let img2 = drawRing(size: selectBtn.size, fill: true)
        selectBtn.setImage(img1, for: .normal )
        selectBtn.setImage(img2, for: .selected)
        selectBtn.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectBtn.isSelected = selected
    }
    
    func drawRing(size: CGSize, fill : Bool) -> UIImage? {
//        print("width:\(size.width) height:\(size.height)")
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: size.height), false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        let lineWidth : CGFloat = 1
        let color1 = UIColor.init(hexString: "#008CFF", transparency: 0.5)!
        let color2 = UIColor.init(hexString: "#008CFF", transparency: 0.3)!
        let color3 = UIColor.init(hexString: "#008CFF")!
        
        let rect1 = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let rect2 = CGRect(x: size.width/4, y: size.height/4, width: size.width/2, height: size.height/2)
        
        ctx.setLineWidth(lineWidth)
        ctx.setFillColor(color1.cgColor)
        ctx.addEllipse(in: rect1)
        ctx.fillPath()
        
        if fill {
            ctx.setFillColor(color3.cgColor)
            let rect2 = CGRect(x: size.width/4, y: size.height/4, width: size.width/2, height: size.height/2)
            ctx.addEllipse(in: rect2)
            ctx.fillPath()
        } else {
            ctx.setStrokeColor(color2.cgColor)
            ctx.addEllipse(in: rect2)
            ctx.strokePath()
        }
        ctx.restoreGState()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}
