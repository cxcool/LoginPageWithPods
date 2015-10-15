//
//  ChatView.swift
//  CowPlan
//
//  Created by 菜 on 15/10/15.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Masonry

class ChatView: UIView {
    
    var username: UITextField?
    var password: UITextField?
    var regist: UIButton?
    var login: UIButton?
    var messageContent: UIView?
    var chatMessage: UITextField?
    var send: UIButton?
    var creatConversation: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        username = UITextField()
        username?.placeholder = "请输入邮箱"
        username?.textAlignment = NSTextAlignment.Center
        username?.borderStyle = UITextBorderStyle.RoundedRect
        self.addSubview(username!)
        username?.mas_makeConstraints {
            make in
            make.width.equalTo()(self.bounds.width * 0.4 - 10)
            make.leading.equalTo()(self.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.mas_top).with().offset()(CGFloat(5))
        }
        password = UITextField()
        password?.placeholder = "请输入密码"
        password?.textAlignment = NSTextAlignment.Center
        password?.borderStyle = UITextBorderStyle.RoundedRect
        password?.secureTextEntry = true
        self.addSubview(password!)
        password?.mas_makeConstraints {
            make in
            make.width.equalTo()(self.bounds.width * 0.4 - 10)
            make.leading.equalTo()(self.username?.mas_trailing).with().offset()(CGFloat(10))
            make.top.equalTo()(self.mas_top).with().offset()(CGFloat(5))
        }
        login = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        login?.setTitle("登陆", forState: UIControlState.Normal)
        self.addSubview(login!)
        login?.mas_makeConstraints {
            make in
            make.leading.equalTo()(self.password?.mas_trailing)
            make.top.equalTo()(self.mas_top).with().offset()(CGFloat(5))
        }
        regist = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        regist?.setTitle("注册", forState: UIControlState.Normal)
        self.addSubview(regist!)
        regist?.mas_makeConstraints {
            make in
            make.trailing.equalTo()(self.mas_trailing).with().offset()(CGFloat(-10))
            make.top.equalTo()(self.mas_top).with().offset()(CGFloat(5))
        }
        messageContent = UIView()
        messageContent?.backgroundColor = UIColor.whiteColor()
        messageContent?.layer.borderWidth = 1
        messageContent?.layer.borderColor = UIColor.grayColor().CGColor
        messageContent?.layer.cornerRadius = 10
        self.addSubview(messageContent!)
        messageContent?.mas_makeConstraints {
            make in
            make.width.equalTo()(self.bounds.width - 20)
            make.height.equalTo()(self.bounds.height * 0.6)
            make.leading.equalTo()(self.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.username?.mas_bottom).with().offset()(CGFloat(5))
        }
        chatMessage = UITextField()
        chatMessage?.borderStyle = UITextBorderStyle.RoundedRect
        self.addSubview(chatMessage!)
        chatMessage?.mas_makeConstraints {
            make in
            make.width.equalTo()(self.bounds.width - 50)
            make.leading.equalTo()(self.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.messageContent?.mas_bottom).with().offset()(CGFloat(5))
        }
        send = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        send?.setTitle("发送", forState: UIControlState.Normal)
        self.addSubview(send!)
        send?.mas_makeConstraints {
            make in
            make.trailing.equalTo()(self.mas_trailing).with().offset()(CGFloat(-10))
            make.top.equalTo()(self.messageContent?.mas_bottom).with().offset()(CGFloat(5))
        }
        creatConversation = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        creatConversation?.setTitle("创建会话", forState: UIControlState.Normal)
        self.addSubview(creatConversation!)
        creatConversation?.mas_makeConstraints {
            make in
            make.centerX.equalTo()(self.mas_centerX)
            make.top.equalTo()(self.chatMessage?.mas_bottom).with().offset()(CGFloat(25))
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //任意背景取消键盘
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent?) {
        username?.resignFirstResponder()
        password?.resignFirstResponder()
        chatMessage?.resignFirstResponder()
        self.becomeFirstResponder()
    }
}
