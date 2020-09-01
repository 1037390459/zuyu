//
//  ResetPassword1Controller.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class ResetPassword1Controller: UIViewController {
    
    @IBOutlet weak var phoneTf: CustomTextField!
    
    @IBOutlet weak var vCodeTf: CustomTextField!
    
    private lazy var rightBtn : UIButton = {
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
       
    func setUpUI() {
        vCodeTf.rightView = rightBtn
        vCodeTf.rightViewMode = .always
    }
    
    @objc func getVCode(_ sender : Any) {
        
    }
    
    @IBAction func next(_ sender: Any) {
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
