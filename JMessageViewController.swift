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
    var targetId: String! = ""
    
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
        chatView.conversationTargetId?.delegate = self
        chatView.login?.addTarget(self, action: "loginToJMessage", forControlEvents: UIControlEvents.TouchUpInside)
        chatView.regist?.addTarget(self, action: "registToJMessage", forControlEvents: UIControlEvents.TouchUpInside)
        chatView.creatConversation?.addTarget(self, action: "createConversation", forControlEvents: UIControlEvents.TouchUpInside)
        chatView.conversationButton?.addTarget(self, action: "getConversation", forControlEvents: UIControlEvents.TouchUpInside)
        chatView.newMessage?.addTarget(self, action: "getNewMessage", forControlEvents: UIControlEvents.TouchUpInside)
        chatView.send?.addTarget(self, action: "sendToJMessage", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(chatView)
    }
    //登陆jmessage用户
    func loginToJMessage() {
        let username = chatView.username?.text!
        let password = chatView.username?.text!
        JMSGUser.loginWithUsername(username, password: password, completionHandler: {
            result, error in
            if error == nil {
                JMSGUser.getUserInfoWithUsername(username, completionHandler: {
                    res, error in
                    if error == nil {
                        let userInfo = res as! JMSGUser
                        self.chatView.userInfo?.text = userInfo.username
                        self.chatView.userInfo?.setNeedsDisplay()
                        var alert = UIAlertView(title: "登陆成功", message:"可以创建聊天了", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }
                })
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
        targetId = chatView.conversationTargetId?.text
        JMSGConversation.createConversation(targetId, withType: JMSGConversationType.Single, completionHandler: {
            result, error in
            if error == nil {
                let res = result as! JMSGConversation
                self.chatView.conversationButton?.setTitle(res.targetName, forState: UIControlState.Normal)
                self.chatView.conversationButton?.setNeedsDisplay()
                println("conversation !!!!!! res = \(res)")
                var alert = UIAlertView(title: "创建会话成功", message: res.targetName, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }else {
                var alert = UIAlertView(title: "创建会话失败", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
    //取得对话
    func getConversation() {
        if targetId != "" {
            JMSGConversation.getConversation(targetId, withType: JMSGConversationType.Single, completionHandler: {
                resultObject, error in
                if error == nil {
                    let result = resultObject as! JMSGConversation
                    self.chatView.conversationMessage?.text = result.latestText
                    self.chatView.conversationMessage?.setNeedsDisplay()
                    println("res=\(result.latestText)")
                }else {
                    var alert = UIAlertView(title: "没有新会话", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
        }else {
            var alert = UIAlertView(title: "targetId = ", message: targetId, delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    //发送消息
    func sendToJMessage() {
        if targetId != "" {
            let message = chatView.chatMessage?.text
            if message != "" {
                JMSGMessage.sendSingleTextMessage(chatView.chatMessage?.text, toUsername: targetId)
                getConversation()
            }else {
                var alert = UIAlertView(title: "发送失败", message: "发送内容不能为空", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }else {
            var alert = UIAlertView(title: "发送失败", message: "发送对象不能为空", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    //新消息
    func getNewMessage() {
        JMSGConversation.getConversationListWithCompletionHandler({
            resultObject, error in
            if error == nil {
                let res = resultObject as! NSArray
                for index in res {
                    println(index.targetName)
                    self.targetId = index.targetName
                    self.chatView.conversationButton?.setTitle(index.targetName, forState: UIControlState.Normal)
                    self.chatView.conversationButton?.setNeedsDisplay()
                }
                var alert = UIAlertView(title: "获取会话列表成功", message: res.count.description, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }else {
                var alert = UIAlertView(title: "获取会话列表失败", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //键盘监听 收起键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case self.chatView.username!:
            self.chatView.username?.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        case self.chatView.password!:
            self.chatView.password?.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        case self.chatView.chatMessage!:
            self.chatView.chatMessage?.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        case self.chatView.conversationTargetId!:
            self.chatView.conversationTargetId?.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        default: return true
        }
    }
}


















