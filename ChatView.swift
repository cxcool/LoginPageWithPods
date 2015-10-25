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
    
    var userInfo: UILabel?
    var conversationTargetId: UITextField?
    var creatConversation: UIButton?
    var newMessage: UIButton?
    
    //conversationList里面的内容
    var messageContent: UIView?
    var conversationButton: UIButton?
    
    //conversationDetail里面内容
    var conversationView: UIView?
    var conversationViewContent: UIView?
    var chatMessage: UITextField?
    var send: UIButton?
    var conversationMessage: UILabel?
    
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
            make.width.equalTo()(self.bounds.width * 0.4)
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
            make.width.equalTo()(self.bounds.width * 0.4)
            make.leading.equalTo()(self.username?.mas_trailing).with().offset()(CGFloat(10))
            make.top.equalTo()(self.mas_top).with().offset()(CGFloat(5))
        }
        login = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        login?.setTitle("登陆", forState: UIControlState.Normal)
        self.addSubview(login!)
        login?.mas_makeConstraints {
            make in
            make.height.equalTo()(CGFloat(20))
            make.trailing.equalTo()(self.mas_trailing).with().offset()(CGFloat(-10))
            make.top.equalTo()(self.mas_top)
        }
        regist = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        regist?.setTitle("注册", forState: UIControlState.Normal)
        self.addSubview(regist!)
        regist?.mas_makeConstraints {
            make in
            make.height.equalTo()(CGFloat(20))
            make.trailing.equalTo()(self.mas_trailing).with().offset()(CGFloat(-10))
            make.top.equalTo()(self.login?.mas_bottom)
        }
        userInfo = UILabel()
        userInfo?.text = "未登录"
        self.addSubview(userInfo!)
        userInfo?.mas_makeConstraints {
            make in
            make.leading.equalTo()(self.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.username?.mas_bottom).with().offset()(CGFloat(10))
        }
        newMessage = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        newMessage?.setTitle("新消息", forState: UIControlState.Normal)
        self.addSubview(newMessage!)
        newMessage?.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(50))
            make.trailing.equalTo()(self.mas_trailing).with().offset()(CGFloat(-10))
            make.top.equalTo()(self.username?.mas_bottom).with().offset()(CGFloat(5))
        }
        creatConversation = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        creatConversation?.setTitle("创建会话", forState: UIControlState.Normal)
        self.addSubview(creatConversation!)
        creatConversation?.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(80))
            make.trailing.equalTo()(self.newMessage?.mas_leading).with().offset()(CGFloat(-5))
            make.top.equalTo()(self.username?.mas_bottom).with().offset()(CGFloat(5))
        }
        conversationTargetId = UITextField()
        conversationTargetId?.placeholder = "对方账户名称"
        conversationTargetId?.textAlignment = NSTextAlignment.Center
        conversationTargetId?.borderStyle = UITextBorderStyle.RoundedRect
        self.addSubview(conversationTargetId!)
        conversationTargetId?.mas_makeConstraints {
            make in
            make.height.equalTo()(CGFloat(25))
            make.leading.equalTo()(self.userInfo?.mas_trailing).with().offset()(CGFloat(20))
            make.trailing.equalTo()(self.creatConversation?.mas_leading).with().offset()(CGFloat(-20))
            make.top.equalTo()(self.username?.mas_bottom).with().offset()(CGFloat(10))
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
            make.height.equalTo()(self.bounds.height * 0.3)
            make.leading.equalTo()(self.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.creatConversation?.mas_bottom).with().offset()(CGFloat(5))
        }
        conversationButton = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        conversationButton?.setTitle("", forState: UIControlState.Normal)
        self.addSubview(conversationButton!)
        conversationButton?.mas_makeConstraints {
            make in
            make.leading.equalTo()(self.messageContent?.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.messageContent?.mas_top)
        }
        conversationView = UIView()
        conversationView?.backgroundColor = UIColor.whiteColor()
        conversationView?.layer.borderWidth = 1
        conversationView?.layer.borderColor = UIColor.grayColor().CGColor
        conversationView?.layer.cornerRadius = 10
        self.addSubview(conversationView!)
        conversationView?.mas_makeConstraints {
            make in
            make.width.equalTo()(self.bounds.width - 20)
            make.height.equalTo()(self.bounds.height * 0.3)
            make.leading.equalTo()(self.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.messageContent?.mas_bottom).with().offset()(CGFloat(15))
        }
        conversationViewContent = UIView()
        conversationViewContent?.backgroundColor = UIColor.whiteColor()
        conversationViewContent?.layer.borderWidth = 1
        conversationViewContent?.layer.borderColor = UIColor.grayColor().CGColor
        conversationViewContent?.layer.cornerRadius = 10
        self.conversationView?.addSubview(conversationViewContent!)
        conversationViewContent?.mas_makeConstraints {
            make in
            make.width.equalTo()(self.bounds.width - 40)
            make.height.equalTo()(self.bounds.height * 0.3 - 55)
            make.leading.equalTo()(self.conversationView?.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.conversationView?.mas_top).with().offset()(CGFloat(10))
        }
        conversationMessage = UILabel()
        conversationMessage?.text = ""
        self.addSubview(conversationMessage!)
        conversationMessage?.mas_makeConstraints {
            make in
            make.leading.equalTo()(self.conversationViewContent?.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.conversationViewContent?.mas_top).with().offset()(CGFloat(10))
        }
        chatMessage = UITextField()
        chatMessage?.borderStyle = UITextBorderStyle.RoundedRect
        self.conversationView?.addSubview(chatMessage!)
        chatMessage?.mas_makeConstraints {
            make in
            make.width.equalTo()(self.bounds.width - 70)
            make.leading.equalTo()(self.conversationView?.mas_leading).with().offset()(CGFloat(10))
            make.top.equalTo()(self.conversationViewContent?.mas_bottom).with().offset()(CGFloat(5))
        }
        send = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        send?.setTitle("发送", forState: UIControlState.Normal)
        self.conversationView?.addSubview(send!)
        send?.mas_makeConstraints {
            make in
            make.trailing.equalTo()(self.conversationView?.mas_trailing).with().offset()(CGFloat(-10))
            make.top.equalTo()(self.conversationViewContent?.mas_bottom).with().offset()(CGFloat(5))
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
        conversationTargetId?.resignFirstResponder()
        self.becomeFirstResponder()
    }
}
