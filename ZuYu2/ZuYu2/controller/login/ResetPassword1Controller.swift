//
//  ResetPassword1Controller.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import RxSwift
import SVProgressHUD

class ResetPassword1Controller: UIViewController {
    
    @IBOutlet weak var phoneTf: CustomTextField!
    
    @IBOutlet weak var vCodeTf: CustomTextField!
    
    let disposeBag = DisposeBag()
    
    var timerDispose : Disposable?
    
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
    
    private lazy var vCodeBtn : UIButton = {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(ResetPassword1Controller.getVCode(_:)), for: .touchUpInside)
        button.setTitle("获取验证码", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 15, bottom: 5, right: 15)
        button.setTitleColorForAllStates(Constant.Color.primary)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.sizeToFit()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    deinit {
        print("deinit:" + ResetPassword1Controller.className)
        timerDispose?.dispose()
    }
       
    func setUpUI() {
        vCodeTf.rightView = vCodeBtn
        vCodeTf.rightViewMode = .always
    }
    
    @objc func getVCode(_ sender : Any) {
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
    
    @IBAction func next(_ sender: Any) {
        guard let phone = phoneTf.text, !phone.isEmpty else {
            view.makeToast("请输入手机号码")
            return
        }
        guard let vcode = vCodeTf.text, !vcode.isEmpty else {
            view.makeToast("请输入验证码")
            return
        }
        performSegue(withIdentifier: ResetPassword2Controller.className, sender: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ResetPassword2Controller.className {
            let vc = segue.destination as! ResetPassword2Controller
        }
    }
    

}
