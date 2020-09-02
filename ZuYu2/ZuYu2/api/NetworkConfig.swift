//
//  NetworkConfig.swift
//  ZuYu2
//
//  Created by Rain on 2020/9/2.
//  Copyright © 2020 million. All rights reserved.
//

import Foundation


enum ResultStatus: Int {

    case PARAMETER_FAIL = 1 //参数错误
    case SUCCESS = 0 //操作成功
    case SUCCESS_1 = 100 //操作成功

    case FAIL = -1 //操作失败

    /*========== token相关 ========== */
    case TOKEN_ERROR_EMPTY = 4000 //"token为空"
    case TOKEN_ERROR_ERROR = 4001 //"token错误"
    case TOKEN_ERROR_EXPIRATION = 4002 //"token过期"
    case TOKEN_ERROR_UNAUTHORIZED = 4003 //"token权限不足"
    case USER_ERROR_ERROR = 4004 //"用户名或密码错误"
    case VISITOR_IS_NOT_ALLOWED = 4005 //"游客访问权限不足"
    case PARAMETERS_IS_NULL = 4006 //"必要参数为空"
    
    case NOT_SUFFICIENT_FUNDS = 4007 //"余额不足"
    case UNSUPPORTED_REGION = 4008 //"暂不支持拨打此区域电话"
    case ENDPOINT_SHORTAGE = 4009 //"endpoint资源不足"
    
    case USER_ERROR_NOT_EXISTEN = 4010 //"用户名不存在"
    case FILE_NOT_UPLOADED = 4011 //"文件未上传"
    
    case NO_USER_COMMISSIONS = 4012 //"没有用户提成
    case USER_ID_IS_NULL = 4013 //"userId为空"
    case MONEY_IS_NUL = 4014 //"申请提现金额为空"
    case ACCOUNT_IS_NULL = 4015 //"提现账户为空"
    case APPLY_FAIL = 4016 //"提现申请失败"
    case BLACK_FRIEND_FAIL = 4017 //"拉黑好友失败"
    
    case VALID_PARAMETER_FAIL = 4018 //"参数校验失败"
    case TRANSLATE_FAIL = 4019 //"翻译失败"
    case TRANSLATE_EXPIRATION = 1100 //"translateid失效"
}


#if false
////生产环境
// http服务地址
var Server_baseURL: String  = "http://192.168.0.121:9310" //

#else
//测试环境
var Server_baseURL: String  = "http://192.168.0.121:9310" //

#endif


/// 定义返回的JSON数据字段
let RESULT_CODE = "resultCode"      //状态码
let CODE_ = "code"      //状态码
let RESULT_MESSAGE = "msg"  //消息提示
let RESULT_DATA = "data"      //状态码

