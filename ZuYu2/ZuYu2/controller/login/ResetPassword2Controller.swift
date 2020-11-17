//
//  ResetPassword2Controller.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class ResetPassword2Controller: UIViewController {
    
    @IBOutlet weak var pwdTf: CustomTextField!
    
    @IBOutlet weak var confirmPwdTf: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sure(_ sender: Any) {
        guard let pwd = pwdTf.text, !pwd.isEmpty else {
            view.makeToast("请输入密码")
            return
        }
        guard let confirmPwd = confirmPwdTf.text, !confirmPwd.isEmpty else {
            view.makeToast("请再次确认密码")
            return
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
