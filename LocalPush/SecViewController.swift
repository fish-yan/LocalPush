//
//  SecViewController.swift
//  LocalPush
//
//  Created by 薛焱 on 16/4/6.
//  Copyright © 2016年 薛焱. All rights reserved.
//

import UIKit

class SecViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func localPush(sender: UIButton) {
        let notification = UILocalNotification()
        //通知延迟的时间
        let date = NSDate(timeIntervalSinceNow: 5)
        notification.fireDate = date
        //重复推送时间间隔(会一直推送,所以需要在特定时间触发取消推送)
        notification.repeatInterval = .Second
        //badge个数
        var badge = UIApplication.sharedApplication().applicationIconBadgeNumber
        badge += 1
        notification.applicationIconBadgeNumber = badge
        //通知声音
        notification.soundName = UILocalNotificationDefaultSoundName
        //通知内容
        notification.alertBody = "这是app在后台的推送"
        //应用内的通知内容
        let userInfo = ["key":"这是app内的推送"]
        notification.userInfo = userInfo
        //通知设置iOS8后需要
        if UIApplication.sharedApplication().respondsToSelector(#selector(UIApplication.registerUserNotificationSettings(_:))) {
            let type:UIUserNotificationType = [UIUserNotificationType.Alert, .Badge, .Sound]
            let setting = UIUserNotificationSettings(forTypes: type, categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(setting)
            //            notification.repeatInterval = .Second
        }
        //注册通知
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
