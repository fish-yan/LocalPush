//
//  AppDelegate.swift
//  LocalPush
//
//  Created by 薛焱 on 16/4/6.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isBackground: Bool!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        isBackground = true
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        isBackground = false
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        //app外部点击通知进来时跳转到对应页面,app内部时不做处理
        if (isBackground == true) {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let contr = self.window?.rootViewController as! UINavigationController
            contr.pushViewController(story.instantiateViewControllerWithIdentifier("SecViewController"), animated: true)
        }
        //通知提示
        let userInfo: NSDictionary = notification.userInfo!
        let alert = UIAlertController(title: "通知", message: userInfo["key"] as? String, preferredStyle: .ActionSheet)
        let action = UIAlertAction(title: "确定", style: .Default) { (action:UIAlertAction) in
            self.window?.rootViewController!.dismissViewControllerAnimated(true, completion: nil)
            //取消通知
            self.cancleLocalNotification("key")
        }
        alert.addAction(action)
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        //badge减一
        var badge = UIApplication.sharedApplication().applicationIconBadgeNumber
        badge -= 1
        badge = badge >= 0 ? badge : 0
        UIApplication.sharedApplication().applicationIconBadgeNumber = badge
        
    }
    
    func cancleLocalNotification(key: NSString) -> Void {
        
        let notifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in notifications! {
            let userInfo:NSDictionary = notification.userInfo!
            for key1 in userInfo.allKeys {
                if key1 as! NSString == key {
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                    break
                }
            }
            
        }
    }

}

