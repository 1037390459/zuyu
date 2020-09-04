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

let networkPlugin = NetworkActivityPlugin { (type, target) in
    switch type {
    case .began:
        SVProgressHUD.show()
    case .ended:
        SVProgressHUD.dismiss()
    }
}

let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<NetTool>.RequestResultClosure) in
    var request = try? endpoint.urlRequest()
    request?.timeoutInterval = 15 //超时15s
}

let provider = MoyaProvider<NetTool>(plugins:[NetworkLoggerPlugin(verbose:true), networkPlugin])

public enum NetTool {
    case getDynamicKey([String : Any])
    case login([String : Any])
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

extension NetTool: Moya.TargetType {
    public var baseURL: URL {
        return URL(string: "http://192.168.0.121:9310")!
    }
    
    public var path: String {
        switch self {
        case .getDynamicKey:
            return "/qx-floor/common/getDynamicKey"
        case .login:
            return "/login"
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
        switch self {
        case .getDynamicKey:
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
        case .getDynamicKey(let dict),
             .login(let dict),
             .qxFloorRegistration(let dict):
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
    
}

extension NetTool {
    @discardableResult
    static func request<Entity : Codable>(_ token: NetTool, entity: Entity.Type) ->Observable<Entity> {
        return provider.rx.request(token, callbackQueue: DispatchQueue.main)
            .asObservable()
            .flatMap { (response : Response) -> Observable<Entity> in
                let subject = PublishSubject<Entity>()
                do {
                    let json = try response.map(ApiBaseModel<Entity>.self)
                    switch json.code! {
                    case 200:
                        subject.onNext(json.data!)
                        subject.onError(RxError.timeout)
                         subject.onCompleted()
                        break
                    case 400:
                        _ = request(.userLogin("", ""), entity: EmptyModel.self).do(onNext: { (_) in
                            request(token, entity: Entity.self)
                        })
                        break
                    default:
                        let msg = json.message ?? "no msg"
                        SVProgressHUD.showError(withStatus: msg) //服务端报错
                        subject.onCompleted()
                        break
                    }
                } catch(let error) {
                    subject.onError(error)
                }
                return subject.asObservable()
        }
    }
}
