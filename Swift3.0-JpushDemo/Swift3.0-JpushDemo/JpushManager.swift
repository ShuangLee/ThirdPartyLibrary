//
//  JpushManager.swift
//  Swift3.0-JpushDemo
//
//  Created by 浮生若梦 on 2016/12/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

import Foundation
import UIKit

class JpushManager {
    // 打开日志debug模式
    class func setDebugMode() {
        JPUSHService.setDebugMode()
    }
    
    // 关闭日志，建议发布时调用此方法
    class func setLogoff() {
        JPUSHService.setLogOFF()
    }
    
    // 开启crash日志收集
    class func crashLogON() {
        JPUSHService.crashLogON()
    }
    
    // 注册通知类型
    class func registerForRemoteNotificationType() {
        //通知类型（这里将声音、消息、提醒角标都给加上）
        let userSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                      categories: nil)
        if ((UIDevice.current.systemVersion as NSString).floatValue >= 8.0) {
            //可以添加自定义categories
            JPUSHService.register(forRemoteNotificationTypes: userSettings.types.rawValue,
                                  categories: nil)
        }
        else {
            //categories 必须为nil
            JPUSHService.register(forRemoteNotificationTypes: userSettings.types.rawValue,
                                  categories: nil)
        }
    }
    
    // 初始化
    class func setup(withOption: [AnyHashable : Any]!, appKey: String!, channel: String, apsForProduction: Bool = false, advertisingIdentifier: String? = nil) {
        registerForRemoteNotificationType()
        
        if advertisingIdentifier != nil {
            JPUSHService.setup(withOption: withOption, appKey: appKey, channel: channel, apsForProduction: apsForProduction, advertisingIdentifier: advertisingIdentifier)
            return
        }
        
        JPUSHService.setup(withOption: withOption, appKey: appKey, channel: channel, apsForProduction: apsForProduction)
    }
    
    // 在appdelegate注册设备处调用 上传deviceToken
    class func register(deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    // ios7以后，才有completion，否则传nil
    class func handle(remoteNotification userinfo: [AnyHashable : Any]!, completion: ((UIBackgroundFetchResult) -> ())?) {
        JPUSHService.handleRemoteNotification(userinfo)
        if completion != nil {
            completion!(UIBackgroundFetchResult.newData)
        }
    }
    
    // 添加登录成功监听通知
    class func addObserver(observer: NSObject, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: Notification.Name.jpfNetworkDidLogin.rawValue), object: nil)
    }
    
    // 移除通知
    class func removeObserver(observer: NSObject) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // 注册别名和标签
    class func setAlias(alias: String = "",tags: Set<AnyHashable>? = nil, callbackSelector: Selector, object: Any) {
        if tags == nil && alias == "" {
            return
        }
        
        if tags == nil && alias != "" {
            JPUSHService.setAlias(alias, callbackSelector: callbackSelector, object: object)
            return
        }
        
        if tags != nil && alias == "" {
            JPUSHService.setTags(tags, callbackSelector: callbackSelector, object: object)
            return
        }
        
        JPUSHService.setTags(tags, alias: alias, callbackSelector: callbackSelector, object: object)
    }
    
    // 监听自定义消息
    class func addReceiveMessageObserver(observer: NSObject, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: Notification.Name.jpfNetworkDidReceiveMessage.rawValue), object: nil)
    }
    
}
