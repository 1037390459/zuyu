//
//  PaiHangBanCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/8.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

///排行榜
class PaiHangBanCell: UITableViewCell {
    
    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var noView: UIView!
    
    @IBOutlet weak var noLbl: UILabel!
    
    let colors1 = [UIColor(red: 0.98, green: 0.64, blue: 0.11, alpha: 1).cgColor, UIColor(red: 1, green: 0.79, blue: 0.22, alpha: 1).cgColor]
    
    let colors2 = [UIColor(red: 0.82, green: 0.81, blue: 0.8, alpha: 1).cgColor, UIColor(red: 0.89, green: 0.88, blue: 0.87, alpha: 1).cgColor]
    
    let colors3 = [UIColor(red: 0.84, green: 0.56, blue: 0.27, alpha: 1).cgColor, UIColor(red: 0.89, green: 0.59, blue: 0.24, alpha: 1).cgColor]
    
    let colors4 = [UIColor(red: 0.98, green: 0.47, blue: 0.59, alpha: 1).cgColor, UIColor(red: 1, green: 0.44, blue: 0.53, alpha: 1).cgColor]
    
    lazy var colorsSet = {
       return [colors1, colors2, colors3, colors4]
    }()
    
    func addLayer(for view : UIView, _ colors : [Any]?) {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = colors
        bgLayer.locations = [0, 1]
        bgLayer.frame = view.bounds
        bgLayer.startPoint = CGPoint(x: 0.25, y: 0)
        bgLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(bgLayer, at: 0)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        mContentView.addShadow(ofColor: Constant.Color.jishiShadow, radius: 16, offset: CGSize.init(width: 0, height: 2), opacity: 1)
        noLbl.backgroundColor = UIColor.clear
        let index =  Int.random(in: 0...3)
        addLayer(for: noView, colorsSet[index])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         noView.roundCorners([.bottomLeft, .topLeft], radius: 100)
    }
    
}
