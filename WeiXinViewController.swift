//
//  WeiXinViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/30.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
//import Alamofire

class WeiXinViewController: UIViewController, WXApiDelegate{
    
    var appid = ""
    var secret = ""
    var code: String?
    var grant_type = ""
    
    var shareButton: UIButton?
    var loginButton: UIButton?
    var message: WXMediaMessage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //登陆按钮
        loginButton = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        loginButton?.setTitle("微信登陆", forState: UIControlState.Normal)
        loginButton?.addTarget(self, action: "loginUseWX", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(loginButton!)
        loginButton?.mas_makeConstraints {
            make in
            make.centerX.equalTo()(self.view.mas_centerX)
            make.centerY.equalTo()(self.view.mas_centerY).with().offset()(CGFloat(-50))
        }
        //分享按钮
        shareButton = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        shareButton?.setTitle("点我分享到微信朋友", forState: UIControlState.Normal)
        shareButton?.addTarget(self, action: "sendMsgToWXSession", forControlEvents: UIControlEvents.TouchUpInside)
        
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
    
    //分享到朋友圈
    func sendMsgToWXSession() {
        if WXApi.isWXAppInstalled() {
            message?.title = "title"
            message?.description = "description"
            message?.setThumbImage(UIImage(named: "messageImage"))
            //多媒体消息(url, 音频等)
            var messageURL = WXWebpageObject()
            messageURL.webpageUrl = "www.baidu.com"
            message?.mediaObject = messageURL
            message?.mediaTagName = "mediaTagName"
            var req = SendMessageToWXReq()
            req.scene = 0 //0会话 1 代表朋友圈
            req.text = "文字标题"
            req.bText = true //发送到会话 默认true
            WXApi.sendReq(req)
        }else {
            var alert = UIAlertView(title: "没有安装微信", message: "请先安装微信", delegate: nil, cancelButtonTitle: "取消")
            alert.show()
        }
    }
    //微信登陆
    func loginUseWX() {
        
        var req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "wx123"
        WXApi.sendReq(req)
    }
    //授权后回调
    func onResp(resp: BaseResp!) {
        println(resp.errCode)
        var aresp = resp as! SendAuthResp
        if aresp.errCode == 0 {
            code = aresp.code
            println(aresp.code)
        }
    }
    //通过code获取access_token
    func getAcccessToken(code: String) {
        let parameters = ["appid": appid, "secret": secret, "code": code, "grant_type": grant_type] //参数
        let url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appid+"&secret="+secret+"&code="+code+"&grant_type="+grant_type
        println(url)
        
    }
}
