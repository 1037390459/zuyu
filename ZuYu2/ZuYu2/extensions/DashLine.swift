//
//  DashLine.swift
//  ZuYu2
//
//  Created by million on 2020/8/6.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

@IBDesignable
class DashLine: UIView {
    
    @IBInspectable
    var strokeColor : UIColor = UIColor.red
    
    @IBInspectable
    var scale : Float = 5
    
    var lineDashPattern: [NSNumber] = [NSNumber(value: 1), NSNumber(value: 2)]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addDashLineLayer()
    }
    
    /// 虚线
    func addDashLineLayer() {
        let width = frame.width
        let height = frame.height
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = min(width, height)
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPhase = 0
        let dashPattern = lineDashPattern.map { (number) -> NSNumber in
            return NSNumber.init(value: number.floatValue * scale)
        }
        shapeLayer.lineDashPattern = dashPattern
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: width > height ? width : 0, y: width > height ? 0 : height))
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
