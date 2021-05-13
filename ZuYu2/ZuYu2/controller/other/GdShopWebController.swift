//
//  GdShopWebController.swift
//  ZuYu2
//
//  Created by Rain on 2021/5/11.
//  Copyright © 2021 million. All rights reserved.
//

import Foundation

class GdShopWebController: WebController {

    override func viewDidLoad() {
        self.url = "\(h5BaseUrl)/qx-gd-app/#/index"
        if let token = getUser()?.accessToken {
            self.url = "\(self.url!)?token=\(token)"
        }
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    override func callNative(code: String?, data: String?, source: String? = nil) {
        super.callNative(code: code, data: data)
        if let code = code, code == "toggleFloor"{
            clientType = .loumian
        }
    }

}
