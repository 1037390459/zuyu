//
//  CustomTextField.swift
//  ZuYu
//
//  Created by million on 2020/7/26.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import SwifterSwift

@IBDesignable
public class CustomTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    @IBInspectable var showEyes: Bool = false
    
    @IBInspectable var paddingLeft: CGFloat = 15 {
        didSet {
            addPaddingLeft(paddingLeft)
        }
    }
    
    @IBInspectable var visibleImg : UIImage? = UIImage.init(named: "eye_visible")
    
    @IBInspectable var invisibleImg : UIImage? = UIImage.init(named: "eye_visible")
    
    private var eyeButton : UIButton = UIButton.init(type: .custom)
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        addEyeBtn()
    }
    
    private func addEyeBtn() {
        guard showEyes else {
            return
        }
        eyeButton.addTarget(self, action: #selector(toggleEye), for: .touchUpInside)
        eyeButton.setImage(visibleImg, for: .normal)
        eyeButton.setImage(invisibleImg, for: .selected)
        eyeButton.contentEdgeInsets = padding
        eyeButton.sizeToFit()
        rightView = eyeButton
        rightViewMode = .always
    }
    
    @objc private func toggleEye() {
        isSecureTextEntry = !isSecureTextEntry
        eyeButton.isSelected = !eyeButton.isSelected
    }

}
