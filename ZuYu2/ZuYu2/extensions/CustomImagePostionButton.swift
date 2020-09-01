//
//  CustomImagePostionButton.swift
//  ZuYu2
//
//  Created by million on 2020/8/4.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

//@IBDesignable
class CustomImagePostionButton: UIButton {
    
    @IBInspectable var titleImagePadding : CGFloat = 5
    
    @IBInspectable var imagePostionValue : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    func setUpUI()  {
        let imagePosition : ImagePostion = ImagePostion(rawValue: imagePostionValue) ?? .imageIsLeft
               setupButtonImageAndTitlePossitionWith(padding: titleImagePadding, style: imagePosition)
       
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
