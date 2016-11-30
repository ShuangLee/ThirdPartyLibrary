//
//  ViewController.swift
//  Swift3.0-WeixinSDK
//
//  Created by 浮生若梦 on 2016/11/30.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //发送给好友还是朋友圈（默认好友）
    var _scene = Int32(WXSceneSession.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //切换发送给好友还是朋友圈
    @IBAction func changeScene(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            _scene = Int32(WXSceneSession.rawValue)
        }else{
            _scene = Int32(WXSceneTimeline.rawValue)
        }
    }
    
    //发送纯文本
    @IBAction func sendTextContent(_ sender: AnyObject) {
        let req = SendMessageToWXReq()
        req.bText = true
        req.text = "不装B还是好朋友👬。"
        req.scene = _scene
        WXApi.send(req)
    }
    
    //发送图片
    @IBAction func sendImageContent(_ sender: AnyObject) {
        let message =  WXMediaMessage()
        
        //发送的图片
        let filePath =  Bundle.main.path(forResource: "userIcon", ofType: "png")
        let image = UIImage(contentsOfFile:filePath!)
        let imageObject =  WXImageObject()
        imageObject.imageData = UIImagePNGRepresentation(image!)
        message.mediaObject = imageObject
        
        //图片缩略图
        let width = 240.0 as CGFloat
        let height = width*image!.size.height/image!.size.width
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image!.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        message.setThumbImage(UIGraphicsGetImageFromCurrentImageContext())
        UIGraphicsEndImageContext()
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
    
    //发送链接
    @IBAction func sendLinkContent(_ sender: AnyObject) {
        let message =  WXMediaMessage()
        
        message.title = "不要装逼"
        message.description = "不装B还是好朋友👬。"
        message.setThumbImage(UIImage(named:"apple.png"))
        
        let ext =  WXWebpageObject()
        ext.webpageUrl = "http://baidu.com"
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
    
    //发送音乐
    @IBAction func sendMusicContent(_ sender: AnyObject) {
        let message =  WXMediaMessage()
        
        message.title = "一无所有"
        message.description = "崔健"
        message.setThumbImage(UIImage(named:"apple.png"))
        
        let ext =  WXMusicObject()
        ext.musicUrl = "http://y.qq.com/portal/song/103347_num.html"
        ext.musicDataUrl = "http://stream20.qqmusic.qq.com/32464723.mp3"
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
    
    //发送视频
    @IBAction func sendVideoContent(_ sender: AnyObject) {
        let message =  WXMediaMessage()
        message.title = "乔布斯访谈"
        message.description = "饿着肚皮，傻逼着。"
        message.setThumbImage(UIImage(named:"apple.png"))
        
        let ext =  WXVideoObject()
        ext.videoUrl = "http://v.youku.com/v_show/id_XNTUxNDY1NDY4.html"
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
    
    //发送非gif格式的表情
    @IBAction func sendNonGifContent(_ sender: AnyObject) {
        let message =  WXMediaMessage()
        message.setThumbImage(UIImage(named:"res5thumb.png"))
        
        let ext =  WXEmoticonObject()
        let filePath = Bundle.main.path(forResource: "res5", ofType: "jpg")
        let url = URL(fileURLWithPath: filePath!)
        ext.emoticonData = try! Data(contentsOf: url)
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
    
    //发送gif格式的表情
    @IBAction func sendGifContent(_ sender: AnyObject) {
        let message =  WXMediaMessage()
        message.setThumbImage(UIImage(named:"res6thumb.png"))
        
        let ext =  WXEmoticonObject()
        let filePath = Bundle.main.path(forResource: "res6", ofType: "gif")
        let url = URL(fileURLWithPath: filePath!)
        ext.emoticonData = try! Data(contentsOf: url)
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
    
    //发送文件
    @IBAction func sendFileContent(_ sender: AnyObject) {
        let message =  WXMediaMessage()
        message.title = "ML.pdf"
        message.description = "Pro CoreData"
        message.setThumbImage(UIImage(named:"apple.png"))
        
        let ext =  WXFileObject()
        ext.fileExtension = "pdf"
        let filePath = Bundle.main.path(forResource: "ML", ofType: "pdf")
        let url = URL(fileURLWithPath: filePath!)
        ext.fileData = try! Data(contentsOf: url)
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = _scene
        WXApi.send(req)
    }
}

