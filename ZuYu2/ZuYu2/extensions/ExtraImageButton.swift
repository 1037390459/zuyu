//
//  ExtraImageButton.swift
//  ZuYu
//
//  Created by million on 2020/7/27.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class ExtraImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI()  {
        contentHorizontalAlignment = .leading
    }
    
    public var padding : CGFloat = 3
    
    public var extraPadding : CGFloat = 4
    
    public var extraImageView : UIImageView! {
        didSet {
            addSubview(extraImageView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        extraImageView.sizeToFit()
        contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: padding + extraPadding + extraImageView.width)
        titleEdgeInsets = UIEdgeInsets.init(top: 0, left: padding, bottom: 0, right: -padding)
        sizeToFit()
        extraImageView.x = width-extraImageView.width
        extraImageView.y = (height-extraImageView.height)/2
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
