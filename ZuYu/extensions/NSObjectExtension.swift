//
//  NSObjectExtension.swift
//  ZuYu
//
//  Created by million on 2020/7/28.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

extension NSObject {
   static var className : String {
        get {
            return String.init(describing: self)
        }
    }
    
}
