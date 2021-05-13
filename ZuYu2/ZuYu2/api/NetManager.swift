//
//  NetManager.swift
//  ZuYu2
//
//  Created by million on 2020/9/13.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit
import Moya
import SVProgressHUD
import RxSwift
import CocoaLumberjack

class NetManager: NSObject {
    public final class CustomPlugin : PluginType {
        public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
            var mRequest = request
            mRequest.timeoutInterval = 15
            return mRequest
        }
        
        public func willSend(_ request: RequestType, target: TargetType) {
            SVProgressHUD.show()
        }
        
        public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
            SVProgressHUD.dismiss()
        }
    }
    
   static func JSONResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }

    static var CustomLogPlugin: PluginType {
       let configuration =  NetworkLoggerPlugin.Configuration.init(formatter: .init(responseData: JSONResponseDataFormatter), output: { (TargetType, items) in
            for item in items {
                DDLogVerbose(item as! String)
            }
        }, logOptions: .verbose)
        
        return NetworkLoggerPlugin.init(configuration: configuration)
    }

    func reversedPrint(_ separator: String, terminator: String, items: Any...) {
        for item in items {
            DDLogVerbose(item as! String)
        }
    }

    
    
//    static let provider = MoyaProvider<NetTool>(plugins:[NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose)),  CustomPlugin()])
    
    static let provider = MoyaProvider<NetTool>(plugins:[CustomLogPlugin,  CustomPlugin()])
    
    
   @discardableResult
   static public func request<Entity : Codable>(_ token: NetTool, entity: Entity.Type) ->Observable<Entity> {
        return provider.rx.request(token, callbackQueue: DispatchQueue.main)
            .asObservable()
            .flatMap { (response : Response) -> Observable<Entity> in
                do {
                    let json = try response.map(ApiBaseModel<Entity>.self)
                    switch json.code! {
                    case 200:
                        return Observable.just(json.data!)
                    case 400:
                        switch clientType {
                        case .gudong, .loumian, .jishi:
                            _ = self.request(.refreshToken(clientType!.rawValue), entity: EmptyModel.self).do(onNext: { (_) in
                                self.request(token, entity: Entity.self)
                            })
                            break
                        default:
                            break
                        }
                        break
                    default:
                        let msg = json.message ?? "no msg"
                        SVProgressHUD.showError(withStatus: msg) //服务端报错
                        break
                    }
                } catch(let error) {
                    return Observable<Entity>.error(error)
                }
                return Observable.empty()
        }
    }
    
}
