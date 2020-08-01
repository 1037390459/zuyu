//
//  ViewController.swift
//  ZuYu
//
//  Created by million on 2020/7/11.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    enum ActionType {
           case password
           case vCode1
           case vCode2
       }

    @IBOutlet weak var phoneStackView: UIStackView!
    
    @IBOutlet weak var phoneTf: UITextField!
    
    @IBOutlet weak var passwordStackView: UIStackView!
    
    @IBOutlet weak var passwordTf: UITextField!
    
    @IBOutlet weak var vCodeStackView: UIStackView!
    
    @IBOutlet weak var vCodeTf1: UITextField!
    
    @IBOutlet weak var vCodeTf2: UITextField!
    
    @IBOutlet weak var vCodeTf3: UITextField!
    
    @IBOutlet weak var vCodeTf4: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var wayLbl: UILabel!
    
    @IBOutlet weak var weChatImgV: UIImageView!
    
    private var actionType : ActionType? {
        didSet{
            switch actionType {
            case .password:
                phoneStackView.isHidden = false
                passwordStackView.isHidden = false
                vCodeStackView.isHidden = true
                loginBtn.setTitle("登录", for: .normal)
                wayLbl.text = "验证码登录"
                break
            case .vCode1:
                phoneStackView.isHidden = false
                passwordStackView.isHidden = true
                vCodeStackView.isHidden = true
                loginBtn.setTitle("获取验证码", for: .normal)
                wayLbl.text = "密码登录"
                break
            case .vCode2:
                phoneStackView.isHidden = true
                passwordStackView.isHidden = true
                vCodeStackView.isHidden = false
                loginBtn.setTitle("确定", for: .normal)
                wayLbl.text = "重新发送验证码"
                break
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private lazy var areaBtn : UIButton = {
        let areaBtn = UIButton.init(type: .custom)
               areaBtn.setTitle("+86", for: .normal)
               areaBtn.setTitleColor(Constant.Color.primaryDark, for: .normal)
               areaBtn.titleLabel?.font = Constant.Font.big
               areaBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
               areaBtn.sizeToFit()
        return areaBtn
    }()
    
    private func setUpUI() {
        loginBtn.layer.shadowColor = UIColor(red: 1, green: 0.6, blue: 0.17, alpha: 0.5).cgColor
        loginBtn.layer.shadowOffset = CGSize(width: 0, height: 2)
        loginBtn.layer.shadowOpacity = 1
        loginBtn.layer.shadowRadius = 6
        loginBtn.layer.cornerRadius = 6
        loginBtn.layer.masksToBounds = true
        phoneTf.leftView = areaBtn
        phoneTf.leftViewMode = .always
        
        actionType = .password
        loginBtn.addTarget(self, action: #selector(LoginController.toggleLoginAction), for: .touchUpInside)
        wayLbl.isUserInteractionEnabled = true
        wayLbl.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(LoginController.toggleLoginWay)))
        weChatImgV.isUserInteractionEnabled = true
        weChatImgV.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(LoginController.loginByWeChat)))
    }
    
    @objc private func toggleEye() {
        passwordTf.isSecureTextEntry = !passwordTf.isSecureTextEntry
    }
    
    @objc private func toggleLoginWay() {
        switch actionType {
        case .password:
            actionType = .vCode1
        case .vCode1:
            actionType = .password
            break
        case .vCode2:
            getVcodeApi()
            break
        default:
            break
        }
    }
    
   @objc private func toggleLoginAction() {
         switch actionType {
         case .password:
             loginApi()
         case .vCode1:
             getVcodeApi()
             break
         case .vCode2:
             loginApi()
             break
         default:
             break
         }
    }
    
    private func loginApi() {
        AppDelegate.shared.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
    private func getVcodeApi() {
        
    }

    @objc private func loginByWeChat() {
              
    }
}

