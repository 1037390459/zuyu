//
//  ModifyPasswordController.swift
//  ZuYu
//
//  Created by million on 2020/7/26.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class ModifyPasswordController: UIViewController {
    
    let padding : CGFloat = 15

    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var passwordConfirmTf: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        passwordTf.placeholder = "请输入手机号"
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(ModifyPasswordController.getVerfiryCode), for: .touchUpInside)
        button.setTitle("获取验证码", for: .normal)
        button.setTitleColor(UIColor.init(hexString: "#53A6FF"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: padding, bottom: 0, right: padding)
        button.sizeToFit()
        //ios13 设置宽高无效 改用约束
        button.heightAnchor.constraint(equalToConstant: passwordTf.height).isActive = true
        passwordTf.rightView = button
        passwordTf.rightViewMode = .always
        passwordConfirmTf.placeholder = "请输入验证码"
    }
    
    /**获取验证码*/
    @objc func getVerfiryCode() {
        
    }

}
