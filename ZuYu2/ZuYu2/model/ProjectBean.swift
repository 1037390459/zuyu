//
//  ProjectBean.swift
//  ZuYu2
//
//  Created by million on 2020/11/11.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation

struct ProjectBean : Codable {
    let projectId : Int?
    let projectName : String?
    let storeId : Int?
    let type : Int?


    enum CodingKeys: String, CodingKey {
        case projectId = "projectId"
        case projectName = "projectName"
        case storeId = "storeId"
        case type = "type"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        projectId = try values.decodeIfPresent(Int.self, forKey: .projectId)
        projectName = try values.decodeIfPresent(String.self, forKey: .projectName)
        storeId = try values.decodeIfPresent(Int.self, forKey: .storeId)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
    }
}
