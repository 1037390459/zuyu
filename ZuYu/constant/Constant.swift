//
//  Constant.swift
//  ZuYu
//
//  Created by million on 2020/7/11.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import SwifterSwift

//public let serverUrl = "http://192.168.0.121" //测试地址

public let serverUrl = "http://120.24.149.42" //正式地址

/// 高德sdk api key
public let amapKey = "55debb8534627997e5146c6a9af80b2c"

public let screenWidth = UIScreen.main.bounds.width

public let screenHeight = UIScreen.main.bounds.height

public let mainHeight : CGFloat = 812

/// 验证码倒计时 s
let countDownSeconds = 60

func statusBarHeight() -> CGFloat {
    var height : CGFloat = 0
    if #available(iOS 13.0, *) {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
        height = UIApplication.shared.statusBarFrame.height
    }
    return height
}

func getUser() ->UserBean? {
    let decoder = JSONDecoder()
    let jsonString = UserDefaults.standard.string(forKey: "userBean")
    if let data = jsonString?.data(using: .utf8) {
        let user = try? decoder.decode(UserBean.self, from: data)
        return user
    }
    return nil
}

public enum VerifyCodeType: String {
    case LOGIN = "LOGIN"
    case REGISTER = "REGISTER"
    case CHANGE_PASSWORD = "CHANGE_PASSWORD"
}

struct Constant {
    
    public struct Color {
        ///客户端
        static public let primary = UIColor.init(named: "primaryColor")!
        static public let lightGray = UIColor.init(named: "lightGrayColor")!
        static public let primaryDark = UIColor.init(named: "primaryDarkColor")!
        static public let lightPrimaryDark = UIColor.init(named: "lightPrimaryDarkColor")!
        static public let red = UIColor.init(named: "redColor")!
        
        ///技师端
        static public let primary2 = UIColor.init(named: "primaryColor2")!
        static public let lightGray2 = UIColor.init(named: "lightGrayColor2")!
        static public let primaryDark2 = UIColor.init(named: "primaryDarkColor2")!
        static public let lightPrimaryDark2 = UIColor.init(named: "lightPrimaryDarkColor2")!
        static public let red2 = UIColor.init(named: "redColor2")!
        static public let line2 = UIColor.init(named: "lineColor2")!
        
    }
    
    public struct Font {
        static public let big = UIFont.systemFont(ofSize: 18)
        static public let normal = UIFont.systemFont(ofSize: 16)
    }
}

