//
//  ViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/9.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate{

    var headView: UIImageView = UIImageView()  //头图片
    var accountLabel: UITextField = UITextField()  //账号
    var passwordLabel: UITextField = UITextField()  //密码
    var loginButton: UIButton = UIButton() //登陆按钮
    var label1: UILabel = UILabel()  //还没有奶牛账号?
    var label2: UILabel = UILabel()  //免费注册
    var label3: UILabel = UILabel()  //忘记密码?
    
    var statusView: UILabel = UILabel() //顶部状态栏遮罩
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageFrame = CGRect(x: 0, y: 0, width: 300, height: 300)
        //button颜色
        let color = UIColor(red: 254/255, green: 201/255, blue: 1/255, alpha: 1)
        //label颜色
        let labelColor = UIColor(red: 61/255, green: 168/255, blue: 224/255, alpha: 1)
        
        //设置每个组件
        //statusBar
        view.addSubview(statusView)
        statusView.backgroundColor = UIColor.blackColor()
        statusView.text = " "
        statusView.mas_makeConstraints { make in
            make.top.equalTo()(self.view.mas_top).with().offset()(CGFloat(0))
            make.left.equalTo()(self.view.mas_left).with().offset()(CGFloat(0))
            make.width.equalTo()(CGFloat(self.view.bounds.size.width))
        }
        
        //改变图片尺寸
        func changeImageSizeWithScale(image: UIImage, scaleSize: CGFloat) -> UIImage? {
            
            //Determine whether the screen is retina
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize), false, 2.0)
            //UIGraphicsBeginImageContext(image.size)
            //UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize))
            image.drawInRect(CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize))
            let changedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return changedImage
        }
        //head
        let image2: UIImage? = UIImage(named: "head0")
        if let image = image2 {
            let compares = image.size.width/self.view.frame.width  //图片的长和屏幕长的比例
            let reSize = 1/compares //将要缩放的比例
            headView.frame = CGRectMake(0, 0, self.view.frame.width, image.size.height * reSize) //设置imageView的窗口大小
            if let reSizeImage = changeImageSizeWithScale(image, reSize) {
                headView.image = reSizeImage //将image加载进imageView
            }
        }else { //没有找到图片资源则进入默认
            headView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height) //设置imageView的窗口大小
        }
        view.addSubview(headView)
        headView.mas_makeConstraints { make in
            make.top.equalTo()(self.view.mas_top).with().offset()(CGFloat(20))
            make.left.equalTo()(self.view.mas_left).with().offset()(CGFloat(0))
        }
        //Account
        view.addSubview(accountLabel)
        accountLabel.delegate = self
        accountLabel.keyboardType = UIKeyboardType.DecimalPad
        accountLabel.placeholder = "  用户名:请输入手机号"
        accountLabel.borderStyle = UITextBorderStyle.RoundedRect
        accountLabel.mas_makeConstraints { make in
            make.top.equalTo()(self.headView.mas_bottom).with().offset()(CGFloat(20))
            make.left.equalTo()(self.view.mas_left).with().offset()(CGFloat(self.view.bounds.size.width * 0.1))
            make.width.equalTo()(CGFloat(self.view.bounds.size.width * 0.8))
        }
        
        //password
        view.addSubview(passwordLabel)
        passwordLabel.delegate = self
        passwordLabel.returnKeyType = UIReturnKeyType.Done
        passwordLabel.placeholder = "  请输入密码"
        passwordLabel.borderStyle = UITextBorderStyle.RoundedRect
        passwordLabel.secureTextEntry = true
        passwordLabel.mas_makeConstraints { make in
            make.top.equalTo()(self.accountLabel.mas_bottom).with().offset()(CGFloat(10))
            make.left.equalTo()(self.view.mas_left).with().offset()(CGFloat(self.view.bounds.size.width * 0.1))
            make.width.equalTo()(CGFloat(self.view.bounds.size.width * 0.8))
        }
        
        //loginButton
        view.addSubview(loginButton)
        loginButton.setTitle("登陆奶牛", forState: UIControlState.Normal)
        loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        loginButton.backgroundColor = color
        loginButton.mas_makeConstraints { make in
            make.top.equalTo()(self.passwordLabel.mas_bottom).with().offset()(CGFloat(40))
            make.left.equalTo()(self.view.mas_left).with().offset()(CGFloat(self.view.bounds.size.width * 0.1))
            make.width.equalTo()(CGFloat(self.view.bounds.size.width * 0.8))
        }
        
        //label1
        view.addSubview(label1)
        label1.text = "还没有奶牛账号?"
        label1.font = UIFont(name: "Arial", size: CGFloat(12))
        label1.mas_makeConstraints { make in
            make.top.equalTo()(self.loginButton.mas_bottom).with().offset()(CGFloat(10))
            make.left.equalTo()(self.view.mas_left).with().offset()(CGFloat(self.view.bounds.size.width * 0.1))
        }
        
        //label2
        view.addSubview(label2)
        label2.text = "免费注册"
        label2.font = UIFont(name: "Arial", size: CGFloat(12))
        label2.textColor = labelColor
        label2.mas_makeConstraints { make in
            make.top.equalTo()(self.loginButton.mas_bottom).with().offset()(CGFloat(10))
            make.left.equalTo()(self.label1.mas_right).with().offset()(CGFloat(self.view.bounds.size.width * 0.05))
        }
        
        //label3
        view.addSubview(label3)
        label3.text = "忘记密码?"
        label3.font = UIFont(name: "Arial", size: CGFloat(12))
        label3.textColor = labelColor
        label3.mas_makeConstraints { make in
            make.top.equalTo()(self.loginButton.mas_bottom).with().offset()(CGFloat(10))
            make.right.equalTo()(self.view.mas_right).with().offset()(CGFloat(-self.view.bounds.size.width * 0.1))
        }
        
        //点击登录
        loginButton.addTarget(self, action: Selector("login"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    //登录
    func login() {
        var connect = LoginToGetResponse()
        //回调函数写法  尾随闭包
        connect.webConnect(accountLabel.text, password: passwordLabel.text) { (isOK) -> Void in
            if isOK {
                println("取得json的封装对象\(connect.data.code!)")
                println("取得json的封装对象\(connect.data.msg!)")
                println("取得json的封装对象\(connect.data.error!)")
            }else {
                println("something wrong !")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //顶部状态栏字体白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    //键盘监听 收起键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case accountLabel:
            accountLabel.resignFirstResponder()
            self.view.becomeFirstResponder()
            return true
        case passwordLabel:
            passwordLabel.resignFirstResponder()
            self.view.becomeFirstResponder()
            return true
        default: return true
        }
    }
    //任意背景取消键盘
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent?) {
        accountLabel.resignFirstResponder()
        passwordLabel.resignFirstResponder()
        self.view.becomeFirstResponder()
    }
}

