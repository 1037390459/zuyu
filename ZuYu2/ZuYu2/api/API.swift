//
//  API.swift
//  ZuYu2
//
//  Created by Rain on 2020/9/2.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation
import Moya
import SVProgressHUD


public enum API {
    case qxFloorRegistration([String : Any])
    case userLogin(String, String)
    case sendCode(String)
    case userRegister(String, String, String, String, String)
    case forgetPass(String, String, String)
    case findUser(String)
    case selectAllNet(page: Int, limit: Int)
    case selectNearbyNet(lat: String, lng: String, name: String? = nil, page: Int, limit: Int)
    case addFault(String, String, Int, String, String, Image)
    case selectUserAppOrder(String, String, String, String)
    case creatPayRecord(Int, String, Int, Int, String)
    case creatSdkToken(String)
}


public protocol MyServerType: TargetType {
    var isShowLoading: Bool { get }
}

extension API: MyServerType {
    
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: Server_baseURL)!
        }
    }
    
    public var path: String {
        switch self {
        case .qxFloorRegistration:
            return "/qx-floor/registration"
            /* 登录模块*/
        case .userLogin:
            return "/user/userLogin"
        case .sendCode:
            return "/user/sendCode"
        case .userRegister:
            return "/user/userRegister"
        case .forgetPass:
            return "/user/forgetPass"
        case .findUser:
            return "/user/findUser"
            
            /* 网点模块*/
        case .selectAllNet:
            return "/shop/selectAllNet"
        case .selectNearbyNet:
            return "/shop/selectNearbyNet"
            
            /* 故障模块*/
        case .addFault:
            return "/device/addFault"
            
            /* 订单模块*/
        case .selectUserAppOrder:
            return "/user/selectUserAppOrder"
        case .creatPayRecord:
            return "/pay/creatPayRecord"
        case .creatSdkToken:
            return "/pay/creatSdkToken"
        }
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Moya.Task {
        switch self {
        case .qxFloorRegistration(let dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
            /* 登录模块*/
        case .userLogin(let userName, let password):
            return .requestParameters(parameters: ["phoneNumber":userName,"passWord":password], encoding: URLEncoding.default)
        case .sendCode(let phoneNumber):
            return .requestParameters(parameters: ["phoneNumber":phoneNumber], encoding: URLEncoding.default)
        case .userRegister(let phoneNumber, let passWord, let vCode, let userName, let email):
            return .requestParameters(parameters:
                ["phoneNumber":phoneNumber, "passWord":passWord, "vCode":vCode, "userName":userName, "email":email], encoding: URLEncoding.default)
        case .forgetPass(let phoneNumber, let vCode, let passWord):
            return .requestParameters(parameters: ["phoneNumber":phoneNumber, "vCode":vCode, "passWord":passWord], encoding: URLEncoding.default)
        case .findUser(let userId):
            return .requestParameters(parameters: ["userId":userId], encoding: URLEncoding.default)
            
            /* 网点模块*/
        case .selectAllNet(let page, let limit):
            return .requestParameters(parameters: ["page" : page, "limit":limit], encoding: URLEncoding.default)
        case .selectNearbyNet(let lat, let lng, let name, let page, let limit):
            var parameters = [String: Any]()
            parameters["lat"] = lat
            parameters["lng"] = lng
            parameters["name"] = name
            parameters["page"] = page
            parameters["limit"] = limit
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .addFault(let userId, let deviceCode, let cause, let otherCause, let content, let image):
            let imageData = image.jpegData(compressionQuality: 1.0)!
            return .uploadCompositeMultipart([MultipartFormData(provider: .data(imageData),
                                                                name: "file",
                                                                fileName: "fault.jpg",
                                                                mimeType: "image/jpg")], urlParameters: ["userId":userId, "deviceCode":deviceCode, "cause":cause, "otherCause":otherCause, "content":content])
            
            /* 订单模块*/
        case .selectUserAppOrder(let userId, let page, let limit, let status):
            return .requestParameters(parameters: ["userId":userId, "page":page, "limit":limit, "status":status], encoding: URLEncoding.default)
        case .creatPayRecord(let userId, let payCode, let payType, let money, let sn):
            return .requestParameters(parameters: ["user_id":userId, "payCode":payCode, "pay_type":payType, "money":money, "sn":sn], encoding: URLEncoding.default)
        case .creatSdkToken(let deviceId):
            return .requestParameters(parameters: ["device_id":deviceId], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
    public var isShowLoading: Bool {
        return true
    }
    
}



