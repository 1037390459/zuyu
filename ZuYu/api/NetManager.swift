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
    
    static let provider = MoyaProvider<NetTool>(plugins:[NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose)),  CustomPlugin()])
    
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
