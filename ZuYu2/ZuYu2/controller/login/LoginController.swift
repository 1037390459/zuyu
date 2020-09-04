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

class LoginController: UIViewController {
    
    let disposeBag = DisposeBag()
    
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
//        clientType = .jishi
//        let subject = PublishSubject<Int>()
//        subject.asObserver().subscribe(onNext :{
//            (element) in
//            print(element)
//            }).disposed(by: disposeBag)
//        subject.onNext(123)
        
        let ob = NetTool.request(.getDynamicKey([:]), entity: Dictionary<String, String>.self)
        ob.subscribe { print("Event:", $0) }.disposed(by: disposeBag)
//        .subscribe(onNext: { [weak self] (result) in
//            print("123123")
//            guard let self = self else { return }
//            }, onError: { (e) in
//                SVProgressHUD.showError(withStatus: e.localizedDescription)
//            }).disposed(by: disposeBag)
        
//        var dict : [String : Any] = [:]
//        dict["code"] = nil
//        dict["iv"] = nil
//        dict["loginType"] = 1
//        dict["mobile"] = phoneTf.text
//        dict["password"] = passwordTf.text
//        let loginObservable =  NetTool.request(.login(dict), entity: EmptyModel.self)
//        .subscribe(onNext: { [weak self] (result) in
//            guard let self = self else { return }
//            }, onError: { (e) in
//                print(e)
//        })
//        .disposed(by: disposeBag)
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
