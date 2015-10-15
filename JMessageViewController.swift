//
//  JPushViewController.swift
//  CowPlan
//
//  Created by 菜 on 15/10/15.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class JMessageViewController: UIViewController, UITextFieldDelegate {
    
    var chatView: ChatView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //顶部遮罩
        var pathView = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 64))
        pathView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(pathView)
        chatView = ChatView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height))
        chatView.username?.delegate = self
        chatView.password?.delegate = self
        chatView.chatMessage?.delegate = self
        chatView.login?.addTarget(self, action: "loginToJMessage", forControlEvents: UIControlEvents.TouchUpInside)
        chatView.regist?.addTarget(self, action: "registToJMessage", forControlEvents: UIControlEvents.TouchUpInside)
        chatView.send?.addTarget(self, action: "sendToJMessage", forControlEvents: UIControlEvents.TouchUpInside)
        chatView.creatConversation?.addTarget(self, action: "createConversation", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(chatView)
        
        //var userInfo = JMSGUser()
        
        //获取用户信息
//        JMSGUser.getUserInfoWithUsername(username!, completionHandler: {
//            result, error in
//            println("result = \(result)") //JMSGUser类型的对象
//            println("error = \(error)")
//        })
    }
    //登陆jmessage用户
    func loginToJMessage() {
        JMSGUser.loginWithUsername(chatView.username?.text, password: chatView.username?.text, completionHandler: {
            result, error in
            if error == nil {
                var alert = UIAlertView(title: "恭喜", message: "登陆成功", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }else {
                var alert = UIAlertView(title: "登陆失败", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
    //注册jmessage用户
    func registToJMessage() {
        JMSGUser.registerWithUsername(chatView.username?.text, password: chatView.username?.text, completionHandler: {
            result, error in
            if error == nil {
                var alert = UIAlertView(title: "恭喜", message: "注册成功", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }else {
                var alert = UIAlertView(title: "注册失败", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
    //创建会话
    func createConversation() {
        JMSGConversation.createConversation("tttt", withType: JMSGConversationType.Single, completionHandler: nil)
    }
    //发送消息
    func sendToJMessage() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //键盘监听 收起键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case self.chatView.username!:
            self.chatView.password?.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        case self.chatView.password!:
            self.chatView.password?.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        case self.chatView.chatMessage!:
            self.chatView.password?.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        default: return true
        }
    }
}


















