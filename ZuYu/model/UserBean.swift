//
//  UserBean.swift
//  ZuYu2
//
//  Created by million on 2020/9/20.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation

struct UserBean : Codable {
    let accessToken : String?
    let avatar : String?
    let empCode : String?
    let mobile : String?
    let nickName : String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case avatar = "avatar"
        case empCode = "empCode"
        case mobile = "mobile"
        case nickName = "nickName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        empCode = try values.decodeIfPresent(String.self, forKey: .empCode)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        nickName = try values.decodeIfPresent(String.self, forKey: .nickName)
    }
    
}
