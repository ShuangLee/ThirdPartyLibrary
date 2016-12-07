//
//  ViewController.swift
//  Swift3.0-JpushDemo
//
//  Created by 浮生若梦 on 2016/12/6.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        JpushManager.addObserver(observer: self,selector:#selector(jpushLoginSuccess))
    }
    
    func jpushLoginSuccess() {
        print("成功")
        // 注册别名 实际应用可以是app登录成功后使用userid注册别名
        //JpushManager.setAlias(alias: "fusheng", callbackSelector: #selector(tagsAliasCallBack), object: self)
        
        // 注册标签
        //获取标签
        var tags = Set<String>()
        tags.insert("movie")
        tags.insert("music")
        tags.insert("game")
        // 单独注册标签
        //JpushManager.setAlias(tags: tags, callbackSelector: #selector(tagsAliasCallBack), object: self)
        
        // 标签 别名 一起注册
        JpushManager.setAlias(alias: "shuang", tags: tags, callbackSelector: #selector(tagsAliasCallBack), object: self)
        
    }

        //别名注册回调
    func tagsAliasCallBack(resCode:CInt, tags:NSSet?, alias:String?) {
        if tags != nil {
             print("响应结果：\(resCode) - 标签:\(tags) - 别名:\(alias)")
        }
        
        print("响应结果：\(resCode) - 别名:\(alias)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        JpushManager.removeObserver(observer: self)
    }
}

