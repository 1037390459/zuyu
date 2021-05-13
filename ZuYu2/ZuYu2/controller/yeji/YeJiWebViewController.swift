//
//  YeJiWebViewController.swift
//  ZuYu2
//
//  Created by Rain on 2021/5/7.
//  Copyright © 2021 million. All rights reserved.
//

import UIKit

class YeJiWebViewController: WebController {

    override func viewDidLoad() {
        
        self.url = "\(h5BaseUrl)/qx-js-app/#/performanceindex"
        if let token = getUser()?.accessToken {
            self.url = "\(self.url!)?token=\(token)"
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
