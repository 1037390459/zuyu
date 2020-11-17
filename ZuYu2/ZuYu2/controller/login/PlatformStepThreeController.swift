//
//  PlatformStepThreeController.swift
//  ZuYu2
//
//  Created by million on 2020/8/2.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class PlatformStepThreeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(done))
    }

   @objc func done() {
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
