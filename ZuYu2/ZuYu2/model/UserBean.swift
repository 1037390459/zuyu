//
//  UserBean.swift
//  ZuYu2
//
//  Created by million on 2020/9/20.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation

struct UserStoreBean : Codable {
    let storeName : String?
    let telephone : String?
    let gstt : String?
    let address : String?
    let businessStart : String?
    let businessEnd : String?
    let goodsValid : Int?

    
//    enum CodingKeys: String, CodingKey {
//        case accessToken = "accessToken"
//        case avatar = "avatar"
//        case empCode = "empCode"
//        case isAdmin = "isAdmin"
//        case name = "name"
//        case positionName = "positionName"
//        case storeId = "storeId"
//        case userType = "userType"
//        case userTypes = "userTypes"
//    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        telephone = try values.decodeIfPresent(String.self, forKey: .telephone)
        gstt = try values.decodeIfPresent(String.self, forKey: .gstt)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        businessStart = try values.decodeIfPresent(String.self, forKey: .businessStart)
        businessEnd = try values.decodeIfPresent(String.self, forKey: .businessEnd)
        goodsValid = try values.decodeIfPresent(Int.self, forKey: .goodsValid)

    }
    
}




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
    let stores : [UserStoreBean]?
    
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
        case stores = "stores"
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
        stores = try values.decodeIfPresent([UserStoreBean].self, forKey: .stores)
    }
    
}

