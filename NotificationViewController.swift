//
//  NotificationViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/29.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Masonry

class NotificationViewController: UIViewController {

    var notificationLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        notificationLabel = UILabel()
        notificationLabel?.text = "切换后台notification"
        self.view.addSubview(notificationLabel!)
        notificationLabel?.mas_makeConstraints {
            make in
            make.center.equalTo()(self.view)
        }
        // Do any additional setup after loading the view.
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
