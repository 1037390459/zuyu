//
//  LoginController.swift
//  ZuYu2
//
//  Created by million on 2020/8/2.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    enum ActionType {
        case password
        case vCode
    }
    
    @IBOutlet weak var phoneTf: UITextField!
    
    @IBOutlet weak var passwordTf: CustomTextField!
    
    @IBOutlet weak var loginWayLbl: UILabel!
    
    @IBOutlet weak var wayBtn: UIButton!
    
    private lazy var rightBtn : UIButton = {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(LoginController.getVCodeOrResetPwd(_:)), for: .touchUpInside)
        button.setTitle("忘记密码", for: .normal)
        button.setTitle("获取验证码", for: .selected)
        button.setTitleColorForAllStates(Constant.Color.primary)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.sizeToFit()
        return button
    }()
    
    private var actionType : ActionType = .password {
        didSet{
            switch actionType {
            case .password:
                loginWayLbl.text = "密码"
                passwordTf.text = nil
                rightBtn.isSelected = false
                rightBtn.sizeToFit()
                break
            case .vCode:
                loginWayLbl.text = "验证码"
                passwordTf.text = nil
                rightBtn.isSelected = true
                rightBtn.sizeToFit()
                break
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        passwordTf.rightView = rightBtn
        passwordTf.rightViewMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func getVCode() {
        print("getVCode")
    }
    
    func resetPassword() {
        print("resetPassword")
        performSegue(withIdentifier: ResetPassword1Controller.className, sender: nil)
    }
    
    @objc func getVCodeOrResetPwd(_ sender : Any) {
        if let button = sender as? UIButton {
            if button.isSelected {
                getVCode()
            }else {
                resetPassword()
            }
        }
    }
    
    @IBAction func toggleLoginWay(_ sender: Any) {
        if actionType == .password {
            actionType = .vCode
        } else {
            actionType = .password
        }
    }
    
    @IBAction func login(_ sender: Any) {
        clientType = .jishi
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
