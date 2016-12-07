# 极光推送
> 极光推送是一个端到端的推送服务，使得服务器端消息能够及时地推送到终端用户手机上。JPush Server 上报 Device Token，免除开发者管理 Device Token 的麻烦。前台运行时，可接收由 JPush 下发的（透传的）自定义消息。灵活管理接收用户：可使用Tag（标签分组）、Alias（用户别名）、RegistrationID（设备注册ID）标记区分用户。

### APNs简介
- `APNs` 是 `Apple Push Notification service` 的简称，中文翻译为：苹果推送通知服务。
- `APNs` 允许设备与苹果的推送通知服务器保持常连接状态。当你想发送一个推送通知给某个用户的iPhone上的应用程序时，你可以使用 `APNs` 发送一个推送消息给目标设备上已安装的某个应用程序。

### 极光推送集成步骤
1. 在极光推送平台创建应用，获得AppKey,并上传你在开发者帐号下创建的推送证书.
	- 具体参考[官方文档](http://docs.jiguang.cn/jpush/client/iOS/ios_guide_new/)
2. 下载官方SDK，将SDK包解压，在Xcode中选择“Add files to 'Your project name'...”，将解压后的lib子文件夹（包含JPUSHService.h、jpush-ios-x.x.x.a，jcore-ios-x.x.x.a）添加到你的工程目录中。
3. 添加Framework
	- CFNetwork.framework
	- CoreFoundation.framework
	- CoreTelephony.framework
	- SystemConfiguration.framework
	- CoreGraphics.framework
	- Foundation.framework
	- UIKit.framework
	- Security.framework
	- libz.tbd (Xcode7以下版本是libz.dylib)
	- AdSupport.framework (获取IDFA需要；如果不使用IDFA，请不要添加)
	- UserNotifications.framework (Xcode8及以上)
	- libresolv.tbd (JPush 2.2.0及以上版本需要, Xcode7以下版本是libresolv.dylib)

### 别名（alias）
- 我们可以给每一个安装了应用程序的用户，取不同别名来标识（比如可以使用用户账号的 userid 来作为别名）。
- 以后给某个特定用户推送消息时，就可以用此别名来指定。
- 每个用户只能指定一个别名。所以同一个设备，新设置的别名会覆盖旧的。
- 如果要删除已有的别名，只要将别名设置为空字符串即可。
- 系统不限定一个别名只能指定一个用户。如果一个别名被指定到了多个用户，当给指定这个别名发消息时，服务器端API会同时给这多个用户发送消息。

####别名使用要求
1. 有效的别名组成：字母（区分大小写）、数字、下划线、汉字。
2. 限制：alias 命名长度限制为 40 字节。（判断长度需采用 UTF-8 编码）

### 标签（tag）
- 前文讲的别名（alias）是为了对每一个用户进行标识。而标签（tag）是用来将用户分类分组，这样便于批量推送消息。
- 可为每个用户打多个标签。（比如： vip、women、game 等等）
- 不同应用程序、不同的用户，可以打同样的标签。
- 每次调用至少设置一个 tag。（这个会覆盖之前的设置，不是新增。）
- 使用空数组或列表表示取消之前的设置。

#### 标签使用要求
- 有效的标签组成：字母（区分大小写）、数字、下划线、汉字。
- 限制：每个 tag 命名长度限制为 40 字节，最多支持设置 100 个 tag，但总长度不得超过 1K 字节。（判断长度需采用 UTF-8 编码）
- 单个设备最多支持设置 100 个 tag。App 全局 tag 数量无限制。

### 发送自定义消息与发送通知的异同
1. 客户端App只有在运行的时候才能收到自定义消息。而通知不同，不管客户端是否在运行都是能够收到推送过来的通知。
2. 发送自定义消息的话不需要通过 APNs，但相较于通知，可以发送更多的内容（当然还是有长度限制的）。
3. 虽然App退出后就没法收到自定义消息，但 JPush 服务器这时会将其保存成离线消息（具体保留时长可以设置）。当App启动后，会自动获取到这条离线消息。
4. 由于发送自定义消息不需要通过 APNs，且客户端在运行时才能接收。所以比较适合用在在线聊天室、即时通讯等相关应用上。
5. 同发送通知一样，发送自定义消息也可以根据别名、标签发送给指定用户，或者广播的形式发给所有人。 
6. 自定义消息同样可以定时发送。

### 接收到消息后处理
- app运行时
- app关闭时
- app在后台时