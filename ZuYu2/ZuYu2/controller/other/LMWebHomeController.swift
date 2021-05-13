//
//  LMWebHomeController.swift
//  ZuYu2
//
//  Created by Rain on 2021/5/11.
//  Copyright © 2021 million. All rights reserved.
//

import Foundation


class LMWebHomeController: WebController {

    override func viewDidLoad() {
        self.url = "\(h5BaseUrl)/qx-floor-app/#/index"
        if let token = getUser()?.accessToken {
            self.url = "\(self.url!)?token=\(token)"
        }
        
        super.viewDidLoad()
//
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func callNative(code: String?, data: String?, source: String? = nil) {
        super.callNative(code: code, data: data)
        if let code = code, code == "toggleStockholders"{
            clientType = .gudong
        }
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
