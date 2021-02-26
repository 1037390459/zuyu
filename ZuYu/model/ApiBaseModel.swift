//
//  ApiBaseModel.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on December 28, 2019

import Foundation

struct ApiBaseModel<T:Codable> : Codable {
    
    let data : T?
    let message : String?
    let code : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case code = "code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(T.self, forKey: .data)
    }
}

