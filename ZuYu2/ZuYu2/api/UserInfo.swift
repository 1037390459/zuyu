//
//  UserInfo.swift
//  ZuYu2
//
//  Created by million on 2020/9/20.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    
    var userBean : UserBean?
    
    static let instance = UserInfo()
    
    public static func sharedInstance() -> UserInfo {
        return instance
    }

}
