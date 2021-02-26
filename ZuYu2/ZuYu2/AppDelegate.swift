//
//  AppDelegate.swift
//  ZuYu
//
//  Created by million on 2020/7/11.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import Toast_Swift
import SVProgressHUD
import IQKeyboardManagerSwift
import AMapFoundationKit
import SystemConfiguration.CaptiveNetwork

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }
    
    var locationManager : CLLocationManager = CLLocationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        globalSettings()
        AMapServices.shared()?.apiKey = amapKey
        requestLocationPermission()
        WXApi.startLog(by: .detail) { (info) in
            print(info)
        }
        WXApi.registerApp(WX_APPID, universalLink: "https://m.sz-mysaas.com/app2")
        print("wifi : \(getWifiName() ?? "")")
        return true
    }
    
    func requestLocationPermission() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                break
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                break
            }
        }
    }
    
    //获取用户使用wifi名称
        func getWifiName() -> String? {
            var wifiName : String = ""
            let wifiInterfaces = CNCopySupportedInterfaces()
            if wifiInterfaces == nil {
                return nil
            }
            let interfaceArr = CFBridgingRetain(wifiInterfaces!) as! Array<String>
            if interfaceArr.count > 0 {
                let interfaceName = interfaceArr[0] as CFString
                let ussafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName)
                
                if (ussafeInterfaceData != nil) {
                    let interfaceData = ussafeInterfaceData as! Dictionary<String, Any>
                    wifiName = interfaceData["SSID"]! as! String
                }
            }
            return wifiName
        }
    
    func globalSettings() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        ToastManager.shared.isTapToDismissEnabled = false
        ToastManager.shared.isQueueEnabled = true
        SVProgressHUD.setDefaultMaskType(.clear)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

// MARK: - 支付回调
extension AppDelegate{
    // iOS 8 及以下请用这个
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.host == "safepay"{//支付宝
            //支付回调
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback:{ (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showResult(result:resultDic! as NSDictionary)
                }
            })
            //授权回调
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showAuth_V2Result(result:resultDic! as NSDictionary)
                }
            })
            return true
        }else{//微信
            return WXApi.handleOpen(url, delegate:WXApiManager.shared)
        }
        
    }
    
    // iOS 9 以上请用这个
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if url.host == "safepay"{//支付宝
            //支付回调
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback:{ (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showResult(result:resultDic! as NSDictionary)
                }
            })
            //授权回调
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showAuth_V2Result(result:resultDic! as NSDictionary)
                }
            })
            return true
        }else{//微信
            return WXApi.handleOpen(url,delegate:WXApiManager.shared)
        }
    }
}
