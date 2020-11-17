//
//  LoginController.swift
//  ZuYu2
//
//  Created by million on 2020/8/2.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD
import Toast_Swift

class LoginController: UIViewController {
    
    enum ActionType {
        case password
        case vCode
    }
    
    @IBOutlet weak var phoneTf: UITextField!
    
    @IBOutlet weak var passwordTf: CustomTextField!
    
    @IBOutlet weak var loginWayLbl: UILabel!
    
    @IBOutlet weak var wayBtn: UIButton!
    
    private lazy var forgetPwdBtn : UIButton = {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        button.setTitle("忘记密码", for: .selected)
        button.setTitleColorForAllStates(Constant.Color.primary)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.sizeToFit()
        return button
    }()
    
    private lazy var vCodeBtn : UIButton = {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(getVCode), for: .touchUpInside)
        button.setTitle("获取验证码", for: .selected)
        button.setTitleColorForAllStates(Constant.Color.primary)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.sizeToFit()
        return button
    }()
    
    private var actionType : ActionType? {
        didSet{
            switch actionType {
            case .password:
                passwordTf.rightView = forgetPwdBtn
                loginWayLbl.text = "密码"
                passwordTf.text = nil
                forgetPwdBtn.isEnabled = true
                forgetPwdBtn.setTitle("忘记密码", for: .normal)
                forgetPwdBtn.sizeToFit()
                break
            case .vCode:
                passwordTf.rightView = vCodeBtn
                loginWayLbl.text = "验证码"
                passwordTf.text = nil
                break
            default:
                break
            }
        }
    }
    
    enum CodeState {
        case get(String)
        case getting(Int)
        case regain(String)
    }
    
    var codeState: CodeState? {
        didSet{
            switch codeState{
            case .get(let desc):
                vCodeBtn.isEnabled = true
                vCodeBtn.setTitle(desc, for: .normal)
                vCodeBtn.sizeToFit()
            case .getting(let value):
                vCodeBtn.isEnabled = false
                vCodeBtn.setTitle("\(value)s后重新获取", for: .normal)
                vCodeBtn.sizeToFit()
            case .regain(let desc):
                vCodeBtn.isEnabled = true
                vCodeBtn.setTitle(desc, for: .normal)
                vCodeBtn.sizeToFit()
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
    
    deinit {
        timerDispose?.dispose()
        print("deinit:" + LoginController.className)
    }
    
    func setUpUI() {
        actionType = .password
        codeState = .get("获取验证码")
        passwordTf.rightView = forgetPwdBtn
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
    
    @objc func getVCode() {
        guard let text = phoneTf.text, !text.isEmpty else {
            view.makeToast("请输入手机号码")
            return
        }
        NetManager.request(.getDynamicKey, entity: Dictionary<String, String>.self)
            .flatMap({(result) -> Observable<Dictionary<String, String>> in
                var dict : [String : Any] = [:]
                dict["type"] = "REGISTER"
                dict["iv"] = result["iv"]
                dict["mobile"] = try? text.aesEncrypt(key: result["key"]!, iv: result["iv"]!)
                return NetManager.request(.sendSmsCode(dict), entity: Dictionary<String, String>.self)
            })
            .subscribe(onNext: { [weak self] (result) in
                print("result:\(result)")
                guard let self = self else { return }
                self.countDown()
                }, onError: { (e) in
                    SVProgressHUD.showError(withStatus: e.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func countDown()  {
        codeState = .getting(countDownSeconds)
        timerDispose = Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance)
            .map { countDownSeconds - $0 }
            .subscribe(onNext: { [weak self] (value) in
                print("value:\(value)")
                guard let self = self else { return }
                if value == 0 {
                    self.codeState = .regain("重新获取验证码")
                    self.timerDispose?.dispose()
                } else {
                    self.codeState = .getting(value)
                }
            })
    }
    
    @objc func resetPassword() {
        print("resetPassword")
        performSegue(withIdentifier: ResetPassword1Controller.className, sender: nil)
    }
    
    @IBAction func toggleLoginWay(_ sender: Any) {
        if actionType == .password {
            actionType = .vCode
        } else {
            actionType = .password
        }
    }
    
    @IBAction func login(_ sender: Any) {
        guard let phone = phoneTf.text, !phone.isEmpty else {
            view.makeToast("请输入手机号码")
            return
        }
        guard let pwdOrVCode = passwordTf.text, !passwordTf.isEmpty else {
            view.makeToast("请输入密码或验证码")
            return
        }
        NetManager.request(.getDynamicKey, entity: Dictionary<String, String>.self)
            .flatMap({[weak self] (result) -> Observable<UserBean> in
                print("result2:\(result)")
                guard let self = self else { return Observable.empty() }
                var dict : [String : Any] = [:]
                if self.actionType == .password {
                    dict["password"] = try? pwdOrVCode.aesEncrypt(key: result["key"]!, iv: result["iv"]!)
                    dict["loginType"] = 2
                }
                if self.actionType == .vCode {
                    dict["code"] = pwdOrVCode
                    dict["loginType"] = 1
                }
                dict["iv"] = result["iv"]
                
                dict["mobile"] = self.phoneTf.text
                return NetManager.request(.login(dict), entity: UserBean.self)
            })
            .subscribe(onNext: { (result) in
                print("result:\(result)")
                let encoder = JSONEncoder()
                let jsonData = try? encoder.encode(result)
                let jsonString = String(bytes: jsonData!, encoding: .utf8)
                let userDefaults = UserDefaults.standard
                userDefaults.set(jsonString, forKey: "userBean")
                clientType = ClientType(rawValue: result.userType ?? "JS")
                }, onError: { (e) in
                    SVProgressHUD.showError(withStatus: e.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}
