//
//  AppDelegate.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/9.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {

    var window: UIWindow?
    //创建一个notification
    let notification = UILocalNotification()
    let categoriesIdentifier = "categories_Identifier"
    let actionHelloIdentifier = "hello_Identifier"
    let actionMissIdentifier = "miss_Identifier"
    //初始化一个bmkmanager
    var mapManager: BMKMapManager?
    var wxKey = "weixin307241868"
    var bmkKey = "v4WtIaNEvAKTIOfw4IwM6G7Q" //baidu地图 appkey
    //umeng
    var umengAppKey = "557e30a567e58e6f68000356" //umeng appkey 公司账户
    //jpush
    var jPushAppKey = "292a76883c31873afb5f8007" //jpush的appkey
    var channel = "" //发行渠道。可不填
    var apsForProduction = false //jpush产品app是否上线
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        //初始化manager
        mapManager = BMKMapManager()
        let ret = mapManager?.start(bmkKey, generalDelegate: nil)
        if !ret! {
            NSLog("百度地图初始化失败, 请检查bmkKey")
        }
        //本地通知
        var actionHello = UIMutableUserNotificationAction()//动作1
        actionHello.identifier = actionHelloIdentifier
        actionHello.title = "hello"
        actionHello.activationMode = UIUserNotificationActivationMode.Foreground
        var actionMiss = UIMutableUserNotificationAction()//动作2
        actionMiss.identifier = actionMissIdentifier
        actionMiss.title = "Miss"
        actionMiss.activationMode = UIUserNotificationActivationMode.Background
        actionMiss.authenticationRequired = true
        actionMiss.destructive = true
        //创建动作类别集合
        var userCategory = UIMutableUserNotificationCategory()
        userCategory.identifier = categoriesIdentifier
        userCategory.setActions([actionHello, actionMiss], forContext: UIUserNotificationActionContext.Minimal)
        var categories: NSSet = NSSet(object: userCategory)
        //注册微信api
        WXApi.registerApp(wxKey)
        
        //umeng启动
        UMessage.startWithAppkey(umengAppKey, launchOptions: launchOptions)
        
        //JMessage启动 同时启动push和message
        JPUSHService.setLogOFF()
        //JPUSHService.setDebugMode()
        JMessage.setupJMessage(launchOptions, appKey: jPushAppKey, channel: channel, apsForProduction: apsForProduction, category: categories as Set<NSObject>)
        if UIDevice.currentDevice().systemVersion >= "8.0" {
            //本地设置
            var userSetting = UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: categories as Set<NSObject>)
            //本地注册
            application.registerUserNotificationSettings(userSetting)
            //Umeng注册
            UMessage.registerRemoteNotificationAndUserNotificationSettings(userSetting)
            UMessage.setLogEnabled(true)
            //JPushc注册
            JPUSHService.registerForRemoteNotificationTypes(UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: categories as Set<NSObject>)
        }else {
            //register remoteNotification types (iOS 8.0以下) 代码会出现警告(建议替换api)
            //UMessage.registerForRemoteNotificationTypes(UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound | UIRemoteNotificationType.Alert)
            println("ios8以下会出现警告")
        }
        println("didFinishLaunchingWithOptions")
        return true
    }
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        println("注册获得的!!!!!!!!!!!!!!!! deviceToken = \(deviceToken)")
        UMessage.registerDeviceToken(deviceToken) //umeng注册token
        JPUSHService.registerDeviceToken(deviceToken) //jpush注册touken
    }
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        println("didReceiveRemoteNotification userinfo = \(userInfo)")
        UMessage.didReceiveRemoteNotification(userInfo) //umeng接受远程推送成功
        JPUSHService.handleRemoteNotification(userInfo) //jpush接受远程推送成功
    }
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println(error) //打印远程推送注册错误
    }
    func applicationWillResignActive(application: UIApplication) {
        println("applicationWillResignActive")
    }
    func applicationDidEnterBackground(application: UIApplication) {
        createNotification()
    }
    func applicationWillEnterForeground(application: UIApplication) {
        println("applicationWillEnterForeground")
    }
    func applicationDidBecomeActive(application: UIApplication) {
        println("applicationDidBecomeActive")
        application.cancelAllLocalNotifications()
        application.applicationIconBadgeNumber = 0
    }
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        println("localNotification")
    }
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        println("identifier\(identifier)")
        //switch identifier...
        completionHandler() //最后一定要调用
    }
    //回调结果
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        println("返回处理结果")
        return WXApi.handleOpenURL(url, delegate: self)
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        println("返回处理结果2")
        return WXApi.handleOpenURL(url, delegate: self)
    }
    //创建通知
    func createNotification() {
        let userInfo: [NSObject: AnyObject] = ["INFO": "msg"]
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        notification.fireDate = NSDate(timeIntervalSinceNow: 2.0)
        notification.timeZone = NSTimeZone.systemTimeZone()
        notification.alertBody = "今天不回家吃饭"
        notification.alertTitle = "您有一条新通知"
        notification.applicationIconBadgeNumber = 1
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = userInfo
        notification.category = categoriesIdentifier
        notification.alertAction = "alert"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
}



















