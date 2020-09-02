//
//  NetworkManager.swift
//  ZuYu2
//
//  Created by Rain on 2020/9/2.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation

import Moya
import Alamofire
import SwiftyJSON

//超时时长
#if DEBUG
private var requestTimeOut: Double = 180
#else
private var requestTimeOut: Double = 180
#endif

enum  RequestResult{
    case success(JSON)
    case error(JSON)
}

//成功数据的回调
typealias successCallback = ((JSON) -> (Void))
//失败的回调
typealias failedCallback = ((JSON) -> (Void))
//网络错误的回调
typealias errorCallback = ((Swift.Error) -> (Void))


public func getToken() -> String{
    return ""
}

//网络请求的设置
private let requestClosure = {(endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        //设置请求时长
        request.timeoutInterval = requestTimeOut
        
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}


private let myEndpointClosure = {(target: API) -> Endpoint in
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    
    var additionalParameters : [String : Any] = [:]
    
    switch target {
    default:
            additionalParameters["token"] = getToken
    }
    
    let defaultEncoding = JSONEncoding.default
    switch target.task {
    case .requestPlain:
        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
    case .requestParameters(var parameters, let encoding):
        additionalParameters.forEach { parameters[$0.key] = $0.value }
        task = .requestParameters(parameters: parameters, encoding: encoding)
    case .uploadCompositeMultipart(let MultipartFormData, var parameters):
        additionalParameters.forEach { parameters[$0.key] = $0.value }
        task = .uploadCompositeMultipart(MultipartFormData, urlParameters: parameters)
    default:
        break
    }
    
    var endpoint = Endpoint(
        url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: task, httpHeaderFields: target.headers
    )
    
    return endpoint
}


//自定义plugins, 拦截器
private var plugins: [PluginType] {
    let activityPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
        
        let targetType = targetType as! MyServerType
        switch(changeType){
        case .began:
            if targetType.isShowLoading {
                
                #warning("show loading ")
                // show loading
            }
        case .ended:
            if targetType.isShowLoading {
                #warning("dissmiss loading ")
                // dissmiss loading
            }
        }
    }
    
    return [activityPlugin, NetworkLoggerPlugin(verbose:true)]
}

////创建网络请求对象
let Provider = MoyaProvider<API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: plugins, trackInflights: false)

/// 取消所有请求
func cancelAllRequest() {
    print("取消所有请求")
    Provider.manager.session.getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
        dataTasks.forEach{ $0.cancel() }
        uploadTasks.forEach { $0.cancel() }
        downloadTasks.forEach { $0.cancel() }
    }
}


func Request(_ target: API, showTips: Bool, completion: @escaping Completion) -> Cancellable{
    return Provider.request(target) { (result) in
        switch result {
        case let .success(response):
            
            guard let jsonData = try? JSON(data: response.data) else {
                print("JSON解析失败:\(response.debugDescription)")
                let error = MoyaError.requestMapping("JSON解析失败:\(response.debugDescription)")
                completion(.failure(error))
                return
            }
            
            var code = 1
            let status = ResultStatus(rawValue: code)
            
            if status == .SUCCESS || status == .SUCCESS_1{
                completion(.success(response))
            }
        case let .failure(error):
            #if DEBUG
            
            #endif
            completion(.failure(error))
        }
    }
}

/// - Parameters:
///   - target: 网络请求
///   - showTips: 显示提示
///   - completion: 成功
///   - failed: 失败
///   - error: 错误
func NetWorkRequestWithReachable(_ target: API, _ showTips: Bool,completion: @escaping successCallback , failed: failedCallback?, errorResult:errorCallback?) -> Cancellable? {
    if !ReachabilityHelper.isReachable() {
        //        #if DEBUG
        if showTips{
            #warning("show tips")
        }
        //        #endif
        if failed != nil {
            let failStr = ["data" : "网络似乎出现了问题"].toJSONString() ?? ""
            let jsonData = try! JSON(parseJSON: failStr)
            failed!(jsonData)
        }
    }
    
    let cancellable = Provider.request(target) { (result) in
        
        switch result {
        case let .success(response):
            do {
                let jsonData = try JSON(data: response.data)
                var msg = jsonData[RESULT_MESSAGE].stringValue
                if let resultMsg = jsonData["resultMsg"].string {
                    //消息没有统一
                    msg = resultMsg
                }
                
                var code = 1
                
                if jsonData[RESULT_CODE] != nil {
                    code = jsonData[RESULT_CODE].intValue
                }
                if let code_ = jsonData["code"].int {
                    //状态码没有统一
                    code = code_
                }
                
                let status = ResultStatus(rawValue: code)
                if status == .SUCCESS || status == .SUCCESS_1{
                    completion(jsonData)
                } else if status == .TOKEN_ERROR_EMPTY || status == .TOKEN_ERROR_ERROR || status == .TOKEN_ERROR_EXPIRATION {

                    
                } else {
                    if let failed = failed {
                        failed(jsonData)
                    }
                }
            } catch {
            }
        case let .failure(error):
            if let failed = failed {
                let failStr = ["data" : error.errorDescription ?? ""].toJSONString() ?? ""
                let jsonData = try! JSON(parseJSON: failStr)
                failed(jsonData)
            }
        }
    }
    
    return cancellable
}

/// - Parameters:
///   - target: 网络请求
///   - completion: 请求成功的回调
func NetWorkRequest(_ target: API, completion: @escaping successCallback ){
    NetWorkRequest(target, completion: completion, failed: nil, errorResult: nil)
}



// - Parameters:
///   - target: 网络请求
///   - completion: 成功的回调
///   - failed: 请求失败的回调
func NetWorkRequest(_ target: API, completion: @escaping successCallback , failed: failedCallback?) {
    NetWorkRequest(target, completion: completion, failed: failed, errorResult: nil)
}

/// - Parameters:
///   - target: 网络请求
///   - completion: 成功
///   - failed: 失败
///   - error: 错误
func NetWorkRequest(_ target: API, completion: @escaping successCallback , failed: failedCallback?, errorResult:errorCallback?) {
    NetWorkRequestWithReachable(target, true, completion: completion, failed: failed, errorResult: errorResult)
}


// - Parameters:
///   - target: 网络请求
///   - completion: 成功的回调
///   - failed: 请求失败的回调
//不处理返回数据
func NetWorkRequestOriginal(_ target: API, completion: @escaping Moya.Completion) -> Cancellable?{
    return Provider.request(target, completion: completion)
}


// MARK: Alamofire直接请求

func NetWorkRequest(url: String, method: HTTPMethod, param: Parameters?) -> DataRequest {
    return NetWorkRequest(url: url, method: method, param: param, encoding: URLEncoding.default, headers: nil)
}

func NetWorkRequest(url: String, method: HTTPMethod, param: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> DataRequest {
    var _headers = headers
    if _headers == nil {
        _headers = ["access_token" : ""]
    }
    
    return Alamofire.request(URL(string: url)!, method: method, parameters: param, encoding: encoding, headers: _headers)
}
