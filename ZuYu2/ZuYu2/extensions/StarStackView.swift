

//
//  StarView.swift
//  ZuYu
//
//  Created by million on 2020/7/28.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

@IBDesignable
class StarStackView: UIStackView {
    
    @IBInspectable var starCount : Int = 5
    
    @IBInspectable var unSelectedImage : UIImage? = UIImage.init(named: "star_normal")
    
    @IBInspectable var selectedImage : UIImage? = UIImage.init(named: "star_normal")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    
    func setUpUI()  {
        axis = .horizontal
        distribution = .fillProportionally
        alignment = .fill
        for index in 1...starCount {
            let starBtn = UIButton.init(type: .custom)
            starBtn.addTarget(self, action: #selector(starBtnTapped(sender:)), for: .touchUpInside)
            starBtn.tag = index
            starBtn.setImage(unSelectedImage, for: .normal)
            starBtn.setImage(selectedImage, for: .selected)
            addArrangedSubview(starBtn)
        }
    }
    
    @objc func starBtnTapped(sender : UIButton)  {
        let index = sender.tag
        for tag in 1...index {
            if let btn = viewWithTag(tag) as? UIButton {
                btn.isSelected = !btn.isSelected
            }
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
