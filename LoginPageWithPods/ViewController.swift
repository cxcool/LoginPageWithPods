//
//  ViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/9.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift

class ViewController: UIViewController{
    var statusView: UILabel = UILabel() //顶部状态栏遮罩
    var homaPage: LoginView = LoginView()
    
       override func viewDidLoad() {
        super.viewDidLoad()
        //初始化登陆界面
        var frame: CGRect = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        homaPage = LoginView(frame: frame)
        homaPage.loginButton.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(homaPage)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //登录
    func login() {
        alertMsg()
        
    }

    //顶部状态栏字体白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //alert
    func alertMsg() {
        let alertController = UIAlertController(title: "", message: "想登陆吗? 小伙子!", preferredStyle: UIAlertControllerStyle.ActionSheet)
        //web
        alertController.addAction(UIAlertAction(title: "并不想", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            println("action 不 !")
            var connect = LoginToGetResponse()
            //回调函数写法  尾随闭包
            connect.webConnect(self.homaPage.accountTextField.text.md5()!, password: self.homaPage.passwordTextField.text.md5()!) { (isOK) -> Void in
                if isOK {
                    println("取得json的封装对象\(connect.data.code!)")
                    println("取得json的封装对象\(connect.data.msg!)")
                    println("取得json的封装对象\(connect.data.error!)")
                }else {
                    println("something wrong !")
                }
            }
            //转场至webView
            self.presentViewController(WebPageViewController(), animated: true, completion: nil)
        }))
        //转到navigationController
        alertController.addAction(UIAlertAction(title: "真的想", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction!) -> Void in
            println("action 好")
            var mainPage = MainNavViewController(rootViewController: MainPageController())
            self.presentViewController(mainPage, animated: true, completion: nil)
        }))
        //cancel
        alertController.addAction(UIAlertAction(title: "算了", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction!) -> Void in
            println("action 取消 !")
        }))
        //another alert
        alertController.addAction(UIAlertAction(title: "==", style: UIAlertActionStyle.Destructive, handler: { (action: UIAlertAction!) -> Void in
            println("action 重置 !")
            let alertSheet = UIAlertController(title: "操", message: "你去问问整个重大有谁敢这么跟我余斌王说话!", preferredStyle: UIAlertControllerStyle.Alert)
            alertSheet.addAction(UIAlertAction(title: "我错了", style: UIAlertActionStyle.Destructive, handler: nil))
            alertSheet.addAction(UIAlertAction(title: "不敢了", style: UIAlertActionStyle.Destructive, handler: nil))
            self.presentViewController(alertSheet, animated: true, completion: nil)
        }))
        //弹出alertMsg
        presentViewController(alertController, animated: true, completion: nil)
    }
}






















