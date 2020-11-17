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
    
   static let networkPlugin = NetworkActivityPlugin { (type, target) in
        switch type {
        case .began:
            SVProgressHUD.show()
        case .ended:
            SVProgressHUD.dismiss()
        }
    }
    
   static let provider = MoyaProvider<NetTool>(plugins:[NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .verbose)), networkPlugin])
    
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
