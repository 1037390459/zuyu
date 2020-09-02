//
//  ReachabilityHelper.swift
//  Translator
//
//  Created by 吴孟 on 2019/6/28.
//  Copyright © 2019 coco. All rights reserved.
//

import UIKit
import Alamofire

class ReachabilityHelper: NSObject {
    static let shared = ReachabilityHelper()
    private let manager: NetworkReachabilityManager = NetworkReachabilityManager()!
    private var isReachable_  = false
    static func startListening() {
        shared.isReachable_ = shared.manager.isReachable
        shared.manager.listener = { status in
            switch status {
            case .notReachable:
                shared.isReachable_ = false
//                UITips.showInfo("当前无网络".localizable())
//                NotificationCenter.default.post(name: AppNotification.networkDisconnect, object: nil)
            case .unknown:
                shared.isReachable_ = false
//                UITips.showInfo("网络未知".localizable())
//                NotificationCenter.default.post(name: AppNotification.networkDisconnect, object: nil)
            case .reachable(.ethernetOrWiFi):
                if !shared.isReachable_ {
                    shared.isReachable_ = true
//                    UITips.showInfo("网络已恢复".localizable())
                }
                
//                NotificationCenter.default.post(name: AppNotification.networkConnect, object: nil)
            case .reachable(.wwan):
                if !shared.isReachable_ {
                    shared.isReachable_ = true
//                    UITips.showInfo("网络已恢复".localizable())
                }
//                NotificationCenter.default.post(name: AppNotification.networkConnect, object: nil)
            }
        }
        shared.manager.startListening()
    }
    
    static func isReachable() -> Bool {
        return shared.manager.isReachable
    }
}
