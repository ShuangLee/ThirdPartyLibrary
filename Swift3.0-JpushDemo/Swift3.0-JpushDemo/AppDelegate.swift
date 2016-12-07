//
//  AppDelegate.swift
//  Swift3.0-JpushDemo
//
//  Created by 浮生若梦 on 2016/12/6.
//  Copyright © 2016年 Ls. All rights reserved.
//
// 待做  消息接收后的处理
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // 启动JPushSDK
        JpushManager.setup(withOption: nil, appKey: "b69e12bc07ea27a513ba1a47",
                           channel: "Publish Channel", apsForProduction: false)
        
        // 监听自定义消息的推送
        JpushManager.addReceiveMessageObserver(observer: self, selector: #selector(didReceiveMessage))
        return true
    }
    
    deinit {
        JpushManager.removeObserver(observer: self)
    }
    
    func didReceiveMessage(notification:Notification) {
        var userInfo =  notification.userInfo!
        //获取推送内容
        let content =  userInfo["content"] as! String
        //获取服务端传递的Extras附加字段，key是自己定义的
        //let extras =  userInfo["extras"]  as! NSDictionary
        //let value1 =  extras["key1"] as! String
        
        //显示获取到的数据
        let alertController = UIAlertController(title: "收到自定义消息",
                                                message: content,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.window?.rootViewController!.present(alertController, animated: true, completion: nil)
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //注册 DeviceToken
        JpushManager.register(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler
        completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //增加IOS 7的支持
        JpushManager.handle(remoteNotification: userInfo, completion: completionHandler)

        print(userInfo)
        //获取通知消息和自定义参数数据
        // 发送通知带附加字段id 和 time 这里只是为了测试功能
        let id = userInfo["id"] as! String
        let time = userInfo["time"] as! String
        let aps = userInfo["aps"] as! NSDictionary
        let alert = aps["alert"] as! String
        
        //显示获取到的数据
        let alertController = UIAlertController(title: alert,
                                                message: "新闻编号：\(id)\n发布时间：\(time)",
            preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.window?.rootViewController!.present(alertController, animated: true, completion: nil)
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //可选
        NSLog("did Fail To Register For Remote Notifications With Error: \(error)")
    }
}

