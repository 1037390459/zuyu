//
//  Constant.swift
//  ZuYu
//
//  Created by million on 2020/7/11.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import SwifterSwift

//public let h5BaseUrl = "http://bisci-vpn.tpddns.cn:65502"

public let h5BaseUrl = "https://qx08.cn"


//public let serverUrl = "http://192.168.0.121:9310" //测试地址

//public let serverUrl = "http://192.168.0.121:9310" //测试地址

public let serverUrl = "https://qx08.cn" //正式地址

/// 高德sdk api key 
public let amapKey = "387ff81741c5fe3f9cb043f46695f7a4"

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

public enum ClientType: String {
    case jishi = "JS"
    case loumian = "LM"
    case gudong = "GD"
    case qiehuan = "QH"
}

public var clientType : ClientType? {
    willSet(newValue) {
        guard let type = newValue, type != clientType else {
            return
        }
        switch type {
        case .jishi, .loumian, .gudong:
            AppDelegate.shared.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: type.rawValue)
            break
        default:
            AppDelegate.shared.window?.rootViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateInitialViewController()
            break
        }
        
    }
}

struct Constant {
    
    public struct Color {
        //客户端
        
        /// #008BFF
        static public let primary = UIColor.init(named: "primaryColor")!
        /// #666666
        static public let lightGray = UIColor.init(named: "lightGrayColor")!
        /// #333333
        static public let primaryDark = UIColor.init(named: "primaryDarkColor")!
        /// #999999
        static public let lightPrimaryDark = UIColor.init(named: "lightPrimaryDarkColor")!
        
        ///技师端
        
        /// #FF6A8F
        static public let jishiPrimary = UIColor.init(named: "jishiPrimaryColor")!
        static public let jishiShadow = UIColor.init(hexString: "#000000", transparency: 0.14)!
        
    }
    
    public struct Font {
        static public let big = UIFont.systemFont(ofSize: 18)
        static public let normal = UIFont.systemFont(ofSize: 16)
    }
    
    public struct Layer {
        
        static func gradientLayer1() -> CAGradientLayer {
            let layer = CAGradientLayer()
            layer.colors = [UIColor(red: 0, green: 0.65, blue: 1, alpha: 1).cgColor, UIColor(red: 0, green: 0.64, blue: 1, alpha: 1).cgColor]
            layer.locations = [0, 1]
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 1, y: 1)
            return layer
        }
        
        static func gradientLayer2() -> CAGradientLayer {
            let layer = CAGradientLayer()
            layer.colors = [UIColor.init(hexString: "#FFEBB4")!.cgColor, UIColor.init(hexString: "#FFE290")!.cgColor]
            layer.locations = [0, 1]
            layer.startPoint = CGPoint(x: 0.65, y: 0)
            layer.endPoint = CGPoint(x: 1, y: 1)
            return layer
        }
        
    }
    
}

