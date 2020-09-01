//
//  TabController.swift
//  ZuYu2
//
//  Created by million on 2020/8/3.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class JSTabController: UITabBarController {
    
    var items : [[String : String]] = [
        ["icon_normal" : "ic_jishi", "ic_select" : "ic_jishi_select", "title" : "技师",],
        ["icon_normal" : "ic_paiwei", "ic_select" : "ic_paiwei_select", "title" : "排位",],
        ["icon_normal" : "ic_call", "ic_select" : "ic_call_select", "title" : "",],
        ["icon_normal" : "ic_yeji", "ic_select" : "ic_yeji_select", "title" : "业绩",],
        ["icon_normal" : "ic_wode", "ic_select" : "ic_wode_select", "title" : "我的",],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let count = viewControllers?.count ?? 0
        for index in 0..<count {
            if let controller = viewControllers?[index] {
                let item = items[index]
                let iconNormal = item["icon_normal"]!
                let iconSelect = item["ic_select"]!
                let title = item["title"]!
                controller.tabBarItem.image = UIImage(named: iconNormal)?.withRenderingMode(.alwaysOriginal)
                controller.tabBarItem.selectedImage = UIImage(named: iconSelect)?.withRenderingMode(.alwaysOriginal)
                controller.tabBarItem.title = title
            }
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
