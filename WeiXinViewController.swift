//
//  WeiXinViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/30.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class WeiXinViewController: UIViewController{
    
    var shareButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        shareButton?.setTitle("点我分享到微信", forState: UIControlState.Normal)
        shareButton?.addTarget(self, action: "sendMsgToWXSession", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(shareButton!)
        shareButton?.mas_makeConstraints {
            make in
            make.center.equalTo()(self.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendMsgToWXSession() {
        var req = SendMessageToWXReq()
        req.scene = 0 //0会话 1 代表朋友圈
        req.text = "文字标题"
        req.bText = true //发送到会话 默认true
        WXApi.sendReq(req)
        //var message:WXMediaMessage = WXMediaMessage()
    }
    
}
