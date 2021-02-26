//
//  StoreBean.swift
//  ZuYu
//
//  Created by million on 2020/12/21.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation

struct StoreList : Codable {
        let current : Int?
        let orders : [Store]?
        let pages : Int?
        let records : [Store]?
        let searchCount : Bool?
        let size : Int?
        let total : Int?

        enum CodingKeys: String, CodingKey {
                case current = "current"
                case orders = "orders"
                case pages = "pages"
                case records = "records"
                case searchCount = "searchCount"
                case size = "size"
                case total = "total"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                current = try values.decodeIfPresent(Int.self, forKey: .current)
                orders = try values.decodeIfPresent([Store].self, forKey: .orders)
                pages = try values.decodeIfPresent(Int.self, forKey: .pages)
                records = try values.decodeIfPresent([Store].self, forKey: .records)
                searchCount = try values.decodeIfPresent(Bool.self, forKey: .searchCount)
                size = try values.decodeIfPresent(Int.self, forKey: .size)
                total = try values.decodeIfPresent(Int.self, forKey: .total)
        }

    struct Store : Codable {
            let ambientScore : Int?
            let collectCount : Int?
            let id : Int?
            let minPrice : Int?
            let orderCount : Int?
            let serviceScore : Int?
            let storeDistance : String?
            let storeName : String?

            enum CodingKeys: String, CodingKey {
                    case ambientScore = "ambientScore"
                    case collectCount = "collectCount"
                    case id = "id"
                    case minPrice = "minPrice"
                    case orderCount = "orderCount"
                    case serviceScore = "serviceScore"
                    case storeDistance = "storeDistance"
                    case storeName = "storeName"
            }
        
            init(from decoder: Decoder) throws {
                    let values = try decoder.container(keyedBy: CodingKeys.self)
                    ambientScore = try values.decodeIfPresent(Int.self, forKey: .ambientScore)
                    collectCount = try values.decodeIfPresent(Int.self, forKey: .collectCount)
                    id = try values.decodeIfPresent(Int.self, forKey: .id)
                    minPrice = try values.decodeIfPresent(Int.self, forKey: .minPrice)
                    orderCount = try values.decodeIfPresent(Int.self, forKey: .orderCount)
                    serviceScore = try values.decodeIfPresent(Int.self, forKey: .serviceScore)
                    storeDistance = try values.decodeIfPresent(String.self, forKey: .storeDistance)
                    storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
            }

    }

}
