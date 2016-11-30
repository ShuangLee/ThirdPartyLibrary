//
//  AppDelegate.swift
//  Swift3.0-WeixinSDK
//
//  Created by 浮生若梦 on 2016/11/30.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?
    
    func alert(title: String, message: String) {
        let alert = UIAlertView(title: title, message: message, delegate: self, cancelButtonTitle: "ok")
        alert.show()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 向微信注册
        WXApi.registerApp("wx495408916da39e06", withDescription: "test")
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    //微信分享完毕后的回调（只有使用真实的AppID才能收到响应）
    //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: SendMessageToWXResp.self) {//确保是对我们分享操作的回调
            if resp.errCode == WXSuccess.rawValue{//分享成功
                print("分享成功")
            }else if resp.errCode == WXErrCodeCommon.rawValue {//普通错误类型
                print("分享失败：普通错误类型")
            }else if resp.errCode == WXErrCodeUserCancel.rawValue {//用户点击取消并返回
                print("分享失败：用户点击取消并返回")
            }else if resp.errCode == WXErrCodeSentFail.rawValue {//发送失败
                print("分享失败：发送失败")
            }else if resp.errCode == WXErrCodeAuthDeny.rawValue {//授权失败
                print("分享失败：授权失败")
            }else if resp.errCode == WXErrCodeUnsupport.rawValue {//微信不支持
                print("分享失败：微信不支持")
            }
        }
    }
    
    //onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
    func onReq(_ req: BaseReq!) {
        if req.isKind(of: GetMessageFromWXReq.self) {
            // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
            alert(title: "微信请求App提供内容", message: "微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信")
        }
        else if req.isKind(of: ShowMessageFromWXReq.self) {
            let temp = req as! ShowMessageFromWXReq
            let msg = temp.message
            
            //显示微信传过来的内容
            let obj = msg?.mediaObject as! WXAppExtendObject
            let strMsg = "标题：\(msg?.title) \n内容：\(msg?.description) \n附带信息：\(obj.extInfo) \n缩略图:\(msg?.thumbData.count) bytes\n\n"
            alert(title: "微信请求App显示内容", message: strMsg)
        }
        else if req.isKind(of: LaunchFromWXReq.self) {
            //从微信启动App
            alert(title: "从微信启动", message: "这是从微信启动的消息")
        }
    }
}

