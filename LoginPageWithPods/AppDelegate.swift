//
//  AppDelegate.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/9.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //创建一个notification
    let notification = UILocalNotification()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound | UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        println("didFinishLaunchingWithOptions")
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        println("applicationWillResignActive")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        createNotification()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        println("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        println("applicationDidBecomeActive")
        application.cancelAllLocalNotifications()
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        println(notification.userInfo)
    }
    
    //创建通知
    func createNotification() {
        let userInfo: [NSObject: AnyObject] = ["INFO": "msg"]
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        notification.fireDate = NSDate(timeIntervalSinceNow: 1.0)
        notification.timeZone = NSTimeZone.systemTimeZone()
        notification.alertBody = "今天不回家吃饭"
        notification.alertTitle = "您有一条新通知"
        notification.applicationIconBadgeNumber = 1
        notification.userInfo = userInfo
        notification.alertAction = "action"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

}



















