//
//  CommonUtils.swift
//  ZuYu2
//
//  Created by million on 2020/11/5.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import CoreLocation

// 跳转到设置界面获得位置授权
func checkLocatePermisson(controller : UIViewController) {

       if(CLLocationManager.authorizationStatus() != .denied) {

           print("应用拥有定位权限")

       }else {

           let alertController = UIAlertController(title: "打开定位开关",

                                                   message: "定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,并允许App使用定位服务",

                                                   preferredStyle: .alert)

           let settingsAction = UIAlertAction(title: "设置", style: .default) { (alertAction) in



            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
               }

           }

           alertController.addAction(settingsAction)

           let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)

           alertController.addAction(cancelAction)

           controller.present(alertController, animated: true, completion: nil)

       }



}
