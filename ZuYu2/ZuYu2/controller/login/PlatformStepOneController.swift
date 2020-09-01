//
//  PlatformStepOneController.swift
//  ZuYu2
//
//  Created by million on 2020/8/2.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class PlatformStepOneController: UIViewController {
    
    @IBOutlet weak var phoneTf: CustomTextField!
    
    @IBOutlet weak var vCodeTf: CustomTextField!
    
    @IBOutlet weak var passwordTf: CustomTextField!
    
    @IBOutlet weak var confirmPwdTf: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
    }
    
    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: PlatformStepTwoController.className, sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == PlatformStepTwoController.className {
           let vc = segue.destination as! PlatformStepTwoController
        }
    }

}
