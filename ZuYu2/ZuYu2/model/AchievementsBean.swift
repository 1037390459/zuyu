//
//  AchievementsBean.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on September 20, 2020

import Foundation

struct AchievementsBean : Codable {

        let jdkf : Int?
        let kdjj : Int?
        let krsl : Int?
        let skyj : Int?
        let spyj : Int?
        let xcyj : Int?
        let xmyj : Int?
        let xzhy : Int?

        enum CodingKeys: String, CodingKey {
                case jdkf = "jdkf"
                case kdjj = "kdjj"
                case krsl = "krsl"
                case skyj = "skyj"
                case spyj = "spyj"
                case xcyj = "xcyj"
                case xmyj = "xmyj"
                case xzhy = "xzhy"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                jdkf = try values.decodeIfPresent(Int.self, forKey: .jdkf)
                kdjj = try values.decodeIfPresent(Int.self, forKey: .kdjj)
                krsl = try values.decodeIfPresent(Int.self, forKey: .krsl)
                skyj = try values.decodeIfPresent(Int.self, forKey: .skyj)
                spyj = try values.decodeIfPresent(Int.self, forKey: .spyj)
                xcyj = try values.decodeIfPresent(Int.self, forKey: .xcyj)
                xmyj = try values.decodeIfPresent(Int.self, forKey: .xmyj)
                xzhy = try values.decodeIfPresent(Int.self, forKey: .xzhy)
        }

}
