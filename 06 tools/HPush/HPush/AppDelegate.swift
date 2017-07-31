//
//  AppDelegate.swift
//  HPush
//
//  Created by cfzq on 2017/7/20.
//  Copyright © 2017年 cfzq. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//MARK: ***JPush
extension AppDelegate: JPUSHRegisterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        applicationDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        applicationDidFailToRegisterForRemoteNotificationsWithError(error: error)
    }
    
    /**
     收到静默推送的回调
     
     @param application  UIApplication 实例
     @param userInfo 推送时指定的参数
     @param completionHandler 完成回调
     */
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        JPUSHService.handleRemoteNotification(userInfo)
        print("iOS7及以上系统，收到通知:\(userInfo)")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
        
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        //JPUSHService.showLocalNotification(atFront: notification, identifierKey: nil)
    }
    
    //注册APNs成功并上报DeviceToken
    fileprivate func applicationDidRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) {
        
        /// Required - 注册 DeviceToken
        JPUSHService.registerDeviceToken(deviceToken)
        //        JPUSHService.setTags(["user"], aliasInbackground: UserHelper.getUserId())
        //        print("deviceToken:\(deviceToken)")
        
    }
    
    //实现注册APNs失败接口（可选）
    fileprivate func applicationDidFailToRegisterForRemoteNotificationsWithError(error: Error) {
        print("did Fail To Register For Remote Notifications With Error:\(error)")
    }
    
    
    fileprivate func setUpJPUSHServiceFunction() {
        
        let entity = JPUSHRegisterEntity()
        entity.types = Int(JPAuthorizationOptions.alert.rawValue | JPAuthorizationOptions.sound.rawValue | JPAuthorizationOptions.badge.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self )
    }
    
    fileprivate func setUpInitJPush(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
        //如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
        let advertisingId: String = ASIdentifierManager.shared().advertisingIdentifier.uuidString as String
        var isProduction: Bool = true
        //init Push
        JPUSHService.setup(withOption: launchOptions, appKey: FSJPushConfigure.appKey, channel: FSJPushConfigure.channelId, apsForProduction: isProduction, advertisingIdentifier: advertisingId)
        
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            if resCode == 0{
                print("registrationID获取成功：\(String(describing: registrationID))")
            }else {
                print("registrationID获取失败：\(String(describing: registrationID))")
            }
        }
    }
    
    //添加处理APNs通知回调方法
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        
        //        let request = notification.request; // 收到推送的请求
        //        let content = request.content; // 收到推送的消息内容
        //
        //        let badge = content.badge;  // 推送消息的角标
        //        let body = content.body;    // 推送消息体
        //        let sound = content.sound;  // 推送消息的声音
        //        let subtitle = content.subtitle;  // 推送消息的副标题
        //        let title = content.title;  // 推送消息的标题
        
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            print("iOS10 前台收到远程通知:\(userInfo)")
            JPUSHService.handleRemoteNotification(userInfo)
        }else {
            // 判断为本地通知
            print("iOS10 前台收到本地通知:\(userInfo)")
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue | UNAuthorizationOptions.sound.rawValue | UNAuthorizationOptions.badge.rawValue))// 需要执行这个方法，选择是否提醒用户，有badge、sound、alert三种类型可以选择设置
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            print("iOS10 收到远程通知:\(userInfo)")
            JPUSHService.handleRemoteNotification(userInfo)// 系统要求执行这个方法
        }
        completionHandler()
    }
    
    
    //设置别名
    fileprivate func setAliasWith(userId: String) {
        //极光推送的别名生成规则暂定如下：md5(前缀+ memberId)  -> md5("ljj_alias_" + "12345678")
        var alias: String = "ljj_alias_" + userId
        /* https://docs.jiguang.cn/jpush/client/iOS/ios_api/
         调用此 API 来设置别名，支持回调函数。
         该方法是 setTagsWithAlias (with Callback) 的简化版本，用于只变更别名的情况。
         支持的版本
         
         开始支持的版本：1.4.0
         接口定义
         + (void)setAlias:(NSString *)alias callbackSelector:(SEL)cbSelector object:(id)theTarget;
         
         alias
         空字符串 （@""）表示取消之前的设置。
         每次调用设置有效的别名，覆盖之前的设置。
         有效的别名组成：字母（区分大小写）、数字、下划线、汉字。
         限制：alias 命名长度限制为 40 字节。（判断长度需采用UTF-8编码）
         callbackSelector
         nil 此次调用不需要 Callback。
         用于回调返回对应的参数 alias, tags。并返回对应的状态码：0为成功，其他返回码请参考错误码定义。
         回调函数请参考SDK 实现。
         theTarget
         参数值为实现了callbackSelector的实例对象。
         nil 此次调用不需要 Callback。
         
         - (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
         NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias)        }
         */
        
        JPUSHService.setAlias(alias.fs.md5(), callbackSelector: #selector(setAliasCompletionAction), object: self)
    }
    
    func setAliasCompletionAction() {
        print("回调别名信息")
    }
    
    
}


