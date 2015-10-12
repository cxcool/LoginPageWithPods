//
//  NotificationViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/29.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Masonry
import Alamofire
import SwiftyJSON

class NotificationViewController: UIViewController {
    
    var timer: NSTimer?
    var weatherLabel: UILabel?
    var notificationLabel: UILabel?
    
    var url = "http://apis.baidu.com/apistore/weatherservice/weather"
    var httpArg = "citypinyin=beijing"
    let apikey = "5d5038d71a15f37aa297e930a6a879fb"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //切换label
        notificationLabel = UILabel()
        notificationLabel?.text = "切换后台notification"
        self.view.addSubview(notificationLabel!)
        notificationLabel?.mas_makeConstraints {
            make in
            make.center.equalTo()(self.view)
        }
        //天气label
        weatherLabel = UILabel()
        weatherLabel?.text = "正在刷新天气"
        self.view.addSubview(weatherLabel!)
        weatherLabel?.mas_makeConstraints {
            make in
            make.top.equalTo()(self.view.mas_top).with().offset()(CGFloat(80))
            make.centerX.equalTo()(self.view.mas_centerX)
        }
        //updateWeather()
        timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "updateWeather", userInfo: nil, repeats: true)
        timer?.fire()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //定时更新页面
    func updateWeather() {
        //获得数据
        var request: Request?
        let parameters = ["citypinyin": "beijing"]
        let headers = ["apikey": apikey]
        Alamofire.request(.GET, url + "?" + httpArg, headers: headers)
            .responseJSON { response in
                if response.2 != nil {
                    let json = JSON(response.2!)
                    //刷新label
                    self.weatherLabel?.text = "temp: "+json["retData"]["temp"].stringValue + "      WD: " + json["retData"]["WD"].stringValue
                }
        }
    }
}







































