//
//  IndicatorButton.swift
//  ZuYu2
//
//  Created by million on 2020/8/5.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class IndicatorButton: UIButton {
    
    var bottomLayerEnabled = false
    
    var bottomLayerSize = CGSize.init(width: 33, height: 2)
    
    var bottomLayerColor = Constant.Color.jishiPrimary

    lazy var bottomLayer : CALayer = {
        let layer = CALayer()
        layer.backgroundColor = bottomLayerColor.cgColor
        return layer
    }()
    
    override var isSelected: Bool{
        didSet {
            if bottomLayerEnabled {
                bottomLayer.isHidden = !isSelected
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let selfSize = bounds.size
        if bottomLayerEnabled {
            let x : CGFloat = (selfSize.width - bottomLayerSize.width)/2
            let y : CGFloat = selfSize.height - bottomLayerSize.height
            bottomLayer.frame = CGRect.init(x: x, y: y, width: bottomLayerSize.width, height: bottomLayerSize.height)
            layer.addSublayer(bottomLayer)
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
