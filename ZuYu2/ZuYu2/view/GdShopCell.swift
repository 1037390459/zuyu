//
//  GdShopCell.swift
//  ZuYu2
//
//  Created by million on 2020/8/16.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class GdShopCell: UITableViewCell {
    
    @IBOutlet weak var mContentView: UIView!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var shopImgV: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var viewBtn: UIButton!
    
    public static var fitHeight : CGFloat = 88+15
    
    let index = Int.random(in: 0..<3)
    
    /// line view background color
    let colorsSet1 : [[CGColor]] = [
        [UIColor(red: 0.41, green: 0.73, blue: 1, alpha: 1).cgColor, UIColor(red: 0.31, green: 0.65, blue: 1, alpha: 1).cgColor],
        [UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.75, blue: 0.11, alpha: 1).cgColor],
        [UIColor(red: 1, green: 0.47, blue: 0.44, alpha: 1).cgColor, UIColor(red: 1, green: 0.36, blue: 0.36, alpha: 1).cgColor],
        ]
    
    ///view btn background color
    let colorsSet2 : [[CGColor]] = [
        [UIColor(red: 0.3, green: 0.78, blue: 1, alpha: 1).cgColor, UIColor(red: 0.22, green: 0.65, blue: 1, alpha: 1).cgColor],
        [UIColor(red: 1, green: 0.8, blue: 0, alpha: 1).cgColor, UIColor(red: 1, green: 0.76, blue: 0.16, alpha: 1).cgColor],
        [UIColor(red: 1, green: 0.47, blue: 0.44, alpha: 1).cgColor, UIColor(red: 1, green: 0.36, blue: 0.36, alpha: 1).cgColor],
    ]
    
    /// shadow color
    let colorSet3 : [UIColor] = [
        UIColor(red: 0, green: 0.62, blue: 1, alpha: 1),
        UIColor(red: 1, green: 0.73, blue: 0, alpha: 1),
        UIColor(red: 1, green: 0.03, blue: 0, alpha: 1),
    ]
    
    func addLayer(for view : UIView, _ colors : [Any]?, _ startPoint : CGPoint = .zero, _ endPoint : CGPoint = .zero) {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = colors
        bgLayer.locations = [0, 1]
        bgLayer.frame = view.bounds
        bgLayer.startPoint = startPoint
        bgLayer.endPoint = endPoint
        view.layer.insertSublayer(bgLayer, at: 0)
    }
    
    lazy var tempView = { () -> UIView in
        let view =  UIView(frame: .zero)
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBtn.backgroundColor = UIColor.clear
        mContentView.addShadow(ofColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.14), radius: 16, offset: CGSize(width: 0, height: 2), opacity: 1)
        viewBtn.addShadow(ofColor: colorSet3[index], radius: 5, offset: CGSize(width: 0, height: 2), opacity: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tempView = UIView(frame: viewBtn.bounds)
        tempView.cornerRadius = 12
        viewBtn.insertSubview(tempView, at: 0)
        addLayer(for: tempView, colorsSet2[index])
        addLayer(for: lineView, colorsSet1[index])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
