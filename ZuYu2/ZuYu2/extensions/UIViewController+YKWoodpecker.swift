//
//  UIViewController+YKWoodpecker.swift
//  ZuYu2
//
//  Created by Rain on 2021/5/8.
//  Copyright © 2021 million. All rights reserved.
//

import Foundation


extension UIViewController{
    
    func setupYKWoodpecker() {
        // 方法监听命令配置JSON地址 * 可选，如无单独配置，可使用 https://github.com/ZimWoodpecker/WoodpeckerCmdSource 上的配置
        YKWoodpeckerManager.sharedInstance()?.cmdSourceUrl = "https://raw.githubusercontent.com/ZimWoodpecker/WoodpeckerCmdSource/master/cmdSource/default/demo.json"
//        #if DEBUG
//        #else
//        // Release 下可开启安全模式，只支持打开安全插件 * 可选
//          YKWoodpeckerManager.sharedInstance()?.safePluginMode = false
//        #endif
        
//        YKWoodpeckerManager.sharedInstance()?.safePluginMode = true
        // 设置 parseDelegate，可通过 YKWCmdCoreCmdParseDelegate 协议实现自定义命令 * 可选
        YKWoodpeckerManager.sharedInstance()?.cmdCore.parseDelegate = self
        YKWoodpeckerManager.sharedInstance()?.show()
        YKWoodpeckerManager.sharedInstance()?.registerCrashHandler()
        YKWoodpeckerManager.sharedInstance()?.registerPlugin(withParameters: ["pluginName" : "XXX",
        "isSafePlugin" : false,
        "pluginInfo" : "by user_XX",
        "pluginCharIconText" : "x",
        "pluginCategoryName" : "自定义",
        "pluginClassName" : "ClassName"])
    }
    
}

extension UIViewController: YKWCmdCoreCmdParseDelegate {
    // MARK: YKWoodpecker
     
    public func cmdCore(_ core: YKWCmdCore!, shouldParseCmd cmdStr: String!) -> Bool {
        if cmdStr.hasPrefix("MyCmd") {
            YKWoodpeckerManager.sharedInstance()?.screenLog.log("Calling my cmd")
            return false
        }
        return true
    }
}
