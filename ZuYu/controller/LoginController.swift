//
//  ViewController.swift
//  ZuYu
//
//  Created by million on 2020/7/11.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD
import Toast_Swift
import CHIOTPField

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
    
    @IBOutlet weak var vCodeTf: UITextField!
    
    @IBOutlet weak var vCodeStackView: UIStackView!
    
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
    
    private var timerDispose : Disposable?
    
    let disposeBag = DisposeBag()
    
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
            guard let password = passwordTf.text, !password.isEmpty else {
                view.makeToast("请输入密码")
                return
            }
             loginApi(password: password)
         case .vCode1:
             getVcodeApi()
             break
         case .vCode2:
             verifyCodeApi()
             break
         default:
             break
         }
    }
    
    private func login() {
        AppDelegate.shared.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
    private func loginApi(code : String? = nil, password : String? = nil) {
        guard let phone = phoneTf.text, !phone.isEmpty else {
            view.makeToast("请输入手机号码")
            return
        }
        NetManager.request(.getDynamicKey, entity: Dictionary<String, String>.self)
            .flatMap({(result) -> Observable<UserBean> in
                var dict : [String : Any] = [:]
                dict["iv"] = result["iv"]
                dict["mobile"] = phone
                if password != nil {
                    dict["password"] = try! password!.aesEncrypt(key: result["key"]!, iv: result["iv"]!)
                    dict["loginType"] = 2
                }
                if code != nil {
                    dict["code"] = code
                    dict["loginType"] = 1
                }
                return NetManager.request(.login(dict), entity: UserBean.self)
            })
            .subscribe(onNext: { [weak self] (result) in
                print("result:\(result)")
                let encoder = JSONEncoder()
                let jsonData = try? encoder.encode(result)
                let jsonString = String(bytes: jsonData!, encoding: .utf8)
                UserDefaults.standard.set(jsonString, forKey: "userBean")
                self?.login()
                }, onError: { (e) in
                    print("error:\(e)")
                    SVProgressHUD.showError(withStatus: e.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    private func getVcodeApi() {
        guard let phone = phoneTf.text, !phone.isEmpty else {
            view.makeToast("请输入手机号码")
            return
        }
        NetManager.request(.getDynamicKey, entity: Dictionary<String, String>.self)
            .flatMap({(result) -> Observable<EmptyModel> in
                var dict : [String : Any] = [:]
                dict["type"] = "LOGIN"
                dict["iv"] = result["iv"]
                dict["mobile"] = try? phone.aesEncrypt(key: result["key"]!, iv: result["iv"]!)
                return NetManager.request(.sendSmsCode(dict), entity: EmptyModel.self)
            })
            .subscribe(onNext: { [weak self] (result) in
                print("result:\(result)")
                self?.actionType = .vCode2
                }, onError: { (e) in
                    print("error:\(e)")
                    SVProgressHUD.showError(withStatus: e.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    private func verifyCodeApi() {
        guard let phone = phoneTf.text, !phone.isEmpty else {
            view.makeToast("请输入手机号")
            return
        }
        guard let code = vCodeTf.text, !code.isEmpty else {
            view.makeToast("请输入验证码")
            return
        }
        let type = VerifyCodeType.LOGIN
        let params : [String : Any] = ["code" : code, "mobile" : phone, "type" : type.rawValue]
        NetManager.request(.verifyCode(params), entity: String.self)
            .subscribe(onNext: { [weak self] (result) in
                print("result:\(result)")
                guard let self = self else { return }
                self.loginApi(code: code)
                }, onError: { (e) in
                    SVProgressHUD.showError(withStatus: e.localizedDescription)
            }).disposed(by: disposeBag)
    }

    @objc private func loginByWeChat() {
              
    }
}

