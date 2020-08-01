//
//  CustomButton.swift
//  ZuYu
//
//  Created by million on 2020/7/26.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

@IBDesignable
public class CustomButton: UIButton {
    
    private var index : UInt32 = 0
    
    @IBInspectable var gradientLayerEnabled : Bool = true
    
    /// custom layer
    public lazy var gradientLayer : CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(red: 1, green: 0.7, blue: 0.36, alpha: 1).cgColor, UIColor(red: 1, green: 0.51, blue: 0.01, alpha: 1).cgColor]
        layer.locations = [0, 1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        return layer
    }()
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayerEnabled {
            gradientLayer.frame = bounds
            layer.insertSublayer(gradientLayer, at: index)
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
