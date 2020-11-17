//
//  PlatformStepOneController.swift
//  ZuYu2
//
//  Created by million on 2020/8/2.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import RxSwift
import Toast_Swift
import SVProgressHUD

class PlatformStepOneController: UIViewController {
    
    @IBOutlet weak var phoneTf: CustomTextField!
    
    @IBOutlet weak var vCodeTf: CustomTextField!
    
    @IBOutlet weak var passwordTf: CustomTextField!
    
    @IBOutlet weak var confirmPwdTf: CustomTextField!
    
    private let disposeBag = DisposeBag()
    
    private var timerDispose : Disposable?
    
    var keyDict : [String : String] = [:]
    
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
    
    lazy var vCodeBtn: UIButton = {
        let vCodeBtn = UIButton(type: .custom)
        vCodeBtn.setTitleColor(Constant.Color.primary, for: .normal)
        vCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        vCodeBtn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        vCodeBtn.sizeToFit()
        vCodeBtn.addTarget(self, action: #selector(getVCode), for: .touchUpInside)
        return vCodeBtn
    }()
    
    @objc func getVCode() {
        guard let text = phoneTf.text, !text.isEmpty else {
            view.makeToast("请输入手机号码")
            return
        }
        NetManager.request(.getDynamicKey, entity: Dictionary<String, String>.self)
            .flatMap({ [weak self] (result) -> Observable<Dictionary<String, String>> in
                print("result2:\(result)")
                guard let self = self else { return Observable.empty()}
                var dict : [String : Any] = [:]
                dict["type"] = "REGISTER"
                dict["iv"] = result["iv"]
                dict["mobile"] = try? text.aesEncrypt(key: result["key"]!, iv: result["iv"]!)
                self.keyDict = result
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    deinit {
        print("deinit:" + PlatformStepOneController.className)
        timerDispose?.dispose()
    }
    
    func setUpUI() {
        codeState = .get("获取验证码")
        vCodeTf.rightView = vCodeBtn
        vCodeTf.rightViewMode = .always
    }
    
    @IBAction func next(_ sender: Any) {
        guard let phone = phoneTf.text, !phone.isEmpty else {
            view.makeToast("请输入手机号码")
            return
        }
        guard let code = vCodeTf.text, !code.isEmpty else {
            view.makeToast("请输入验证码")
            return
        }
        guard let pwd = passwordTf.text, !pwd.isEmpty else {
            view.makeToast("请输入密码")
            return
        }
        guard let confirmPwd = confirmPwdTf.text, !confirmPwdTf.isEmpty else {
            view.makeToast("请再次输入密码")
            return
        }
        guard pwd == confirmPwd else {
            view.makeToast("请输入一致的密码")
            return
        }
        performSegue(withIdentifier: PlatformStepTwoController.className, sender: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlatformStepTwoController.className {
            let vc = segue.destination as! PlatformStepTwoController
            vc.regMobile = phoneTf.text
            vc.code = vCodeTf.text
            vc.password = passwordTf.text
        }
    }
    
}
