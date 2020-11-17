//
//  NetTool.swift
//  Zuyu2
//
//  Created by million on 2019/12/28.
//  Copyright © 2019 million. All rights reserved.
//

import Foundation
import Moya
import SVProgressHUD
import RxSwift

public enum NetTool {
    case getDynamicKey
    case login([String : Any])
    case refreshToken(String)
    case qxFloorRegistration([String : Any])
    case sendSmsCode([String : Any])
    case uploadData(String, Data)
    case uploadBase64(String, Data)
    
    /* 楼面端*/
    case achievements
    
    /* 技师端*/
    case callProject([String : Any])
    case callWaiter([String : Any])
    case getAllProjectList([String : Any])
}

extension NetTool: Moya.TargetType {
    public var baseURL: URL {
        return URL(string: serverUrl)!
    }
    
    public var path: String {
        switch self {
        case .getDynamicKey:
            return "/qx-floor/common/getDynamicKey"
        case .login:
            return "/qx-floor/login"
        case .refreshToken(let userType):
            return "qx-floor/home/\(userType)"
        case .sendSmsCode:
            return "/qx-floor/common/sendSmsCode"
        case .qxFloorRegistration:
            return "/qx-floor/registration"
        case .uploadData:
            return "/qx-floor/file-manage/upload"
        case .uploadBase64:
            return "/qx-floor/file-manage/uploadBase64"
            
        /* 楼面端*/
        case .achievements:
            return "/qx-floor/home/achievements"
            
        /* 技师端*/
        case .callProject:
            return "/qx-floor/callService/callProject"
        case .callWaiter:
            return "/qx-floor/callService/callWaiter"
        case .getAllProjectList:
            return "/qx-floor/callService/getAllProjectList"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getDynamicKey,
             .refreshToken,
             .achievements:
            return .get
        default:
            return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Moya.Task {
        switch self {
        case .getDynamicKey,
             .refreshToken,
             .achievements
            :
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .login(let dict),
             .sendSmsCode(let dict),
             .qxFloorRegistration(let dict),
             .callProject(let dict),
             .callWaiter(let dict),
             .getAllProjectList(let dict)
            :
            return .requestParameters(parameters: dict, encoding: JSONEncoding.default)
        case .uploadData(let fileName, let data),
             .uploadBase64(let fileName, let data)
            :
            print("data len: \(data.count)")
            return .uploadMultipart([MultipartFormData(provider: .data(data),
                                                       name: "file",
                                                       fileName: fileName,
                                                       mimeType: "application/octet-stream")])
            
        }
    }
    
    public var headers: [String : String]? {
        var headers : [String : String] = [:]
        headers["Content-Type"] = "application/json"
        if let user = getUser() {
            let token = user.accessToken
            headers["accessToken"] = token
        }
        return headers
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
