//
//  ProjectBean.swift
//  ZuYu2
//
//  Created by million on 2020/11/10.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation

struct ProjectsBean : Codable {

    let list : [ProjectBean]?
    let total : String?
    let totalNumber : Int?


    enum CodingKeys: String, CodingKey {
        case list = "list"
        case total = "total"
        case totalNumber = "totalNumber"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([ProjectBean].self, forKey: .list)
        total = try values.decodeIfPresent(String.self, forKey: .total)
        totalNumber = try values.decodeIfPresent(Int.self, forKey: .totalNumber)
    }

}


