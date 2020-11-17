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
    let isAdmin : Int?
    let name : String?
    let positionName : String?
    let storeId : Int?
    let userType : String?
    let userTypes : [String]?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
        case avatar = "avatar"
        case empCode = "empCode"
        case isAdmin = "isAdmin"
        case name = "name"
        case positionName = "positionName"
        case storeId = "storeId"
        case userType = "userType"
        case userTypes = "userTypes"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        empCode = try values.decodeIfPresent(String.self, forKey: .empCode)
        isAdmin = try values.decodeIfPresent(Int.self, forKey: .isAdmin)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        positionName = try values.decodeIfPresent(String.self, forKey: .positionName)
        storeId = try values.decodeIfPresent(Int.self, forKey: .storeId)
        userType = try values.decodeIfPresent(String.self, forKey: .userType)
        userTypes = try values.decodeIfPresent([String].self, forKey: .userTypes)
    }
    
}
