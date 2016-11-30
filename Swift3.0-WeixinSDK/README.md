# 微信SDK集成
> 通过调用微信提供的API接口，可以很方便的在应用中发送消息给微信好友，也可以分享文章、图片等到朋友圈。
[微信开发平台](https://open.weixin.qq.com)

### 实现功能
1. 发送各种类型的消息给好友
	- 内容类型：纯文本、图片、链接、音乐、视频、gif图片、表情、文件等
2. 分享到朋友圈

### 集成步骤
1. 拖入微信sdk文件夹到项目中

![](http://ohdxn33p5.bkt.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202016-11-30%20%E4%B8%8B%E5%8D%885.48.27.png)

2. 由于是Swift，需要建立桥接文件，导入微信sdk相关头文件

![](http://ohdxn33p5.bkt.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202016-11-30%20%E4%B8%8B%E5%8D%885.50.51.png)

3. 导入相关类库

![](http://ohdxn33p5.bkt.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202016-11-30%20%E4%B8%8B%E5%8D%885.57.39.png)

4. 自iOS 9起，系统策略更新，限制了http协议的访问，此外应用需要在“Info.plist”中将要使用的URL Schemes列为白名单。
在“Info.plist”里增加如下代码

```
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>weixin</string>
</array>
<key>LSRequiresIPhoneOS</key>
<true/>
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

5. 在 “info” -> “URL Types”中，新增一个 URL Schemes。新的 Schemes 命名是便是你注册的 AppID。（URL Schemes 的配置是为了让你跳转到微信发送消息后，还能跳回原来的App上。

![](http://ohdxn33p5.bkt.clouddn.com/%E5%B1%8F%E5%B9%95%E5%BF%AB%E7%85%A7%202016-11-30%20%E4%B8%8B%E5%8D%886.04.48.png)
	
### 注意事项
- 必须真机调试
- 必须使用注册的AppID才可以发送消息。否则会报“由于bad_param，无法分享到微信”错误。
