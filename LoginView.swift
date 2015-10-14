//
//  loginView.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/11.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
//import Alamofire

class LoginView: UIView, UITextFieldDelegate {
    
    //var loginView:UIViewController = UIViewController()
    var headView: UIImageView = UIImageView()  //头图片
    var accountTextField: UITextField = UITextField()  //账号
    var passwordTextField: UITextField = UITextField()  //密码
    var loginButton: UIButton = UIButton() //登陆按钮
    var loginImage: UIImageView = UIImageView() //登陆图片
    var notGetAccount: UILabel = UILabel()  //还没有奶牛账号?
    var regist: UILabel = UILabel()  //免费注册
    var forgetPassword: UILabel = UILabel()  //忘记密码?
    //顶部状态栏遮罩
    var statusView: UILabel = UILabel()
    //图片框默认大小
    let imageFrame = CGRect(x: 0, y: 0, width: 300, height: 300)
    //button颜色
    let color = UIColor(red: 254/255, green: 201/255, blue: 1/255, alpha: 1)
    //label颜色
    let labelColor = UIColor(red: 61/255, green: 168/255, blue: 224/255, alpha: 1)
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
            //图片框默认大小
            let imageFrame = CGRect(x: 0, y: 0, width: 300, height: 300)
            //button颜色
            let color = UIColor(red: 254/255, green: 201/255, blue: 1/255, alpha: 1)
            //label颜色
            let labelColor = UIColor(red: 61/255, green: 168/255, blue: 224/255, alpha: 1)

            //设置每个组件
            //statusBar
            self.addSubview(statusView)
            statusView.backgroundColor = UIColor.blackColor()
            statusView.text = " "
            statusView.mas_makeConstraints { make in
                make.top.equalTo()(self.mas_top).with().offset()(CGFloat(0))
                make.left.equalTo()(self.mas_left).with().offset()(CGFloat(0))
                make.width.equalTo()(CGFloat(self.bounds.size.width))
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
            let image2: UIImage? = UIImage(named: "head")
            if let image = image2 {
                let compares = image.size.width/self.frame.width  //图片的长和屏幕长的比例
                let reSize = 1/compares //将要缩放的比例
                headView.frame = CGRectMake(0, 0, self.frame.width, image.size.height * reSize) //设置imageView的窗口大小
                if let reSizeImage = changeImageSizeWithScale(image, reSize) {
                    headView.image = reSizeImage //将image加载进imageView
                }
            }else { //没有找到图片资源则进入默认
                headView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height) //设置imageView的窗口大小
            }
            self.addSubview(headView)
            headView.mas_makeConstraints { make in
                make.top.equalTo()(self.mas_top).with().offset()(CGFloat(20))
                make.left.equalTo()(self.mas_left).with().offset()(CGFloat(0))
            }
            //Account
            self.addSubview(accountTextField)
            accountTextField.delegate = self
            accountTextField.keyboardType = UIKeyboardType.DecimalPad
            accountTextField.placeholder = "  用户名:请输入手机号"
            accountTextField.borderStyle = UITextBorderStyle.RoundedRect
            accountTextField.mas_makeConstraints { make in
                make.top.equalTo()(self.headView.mas_bottom).with().offset()(CGFloat(20))
                make.left.equalTo()(self.mas_left).with().offset()(CGFloat(self.bounds.size.width * 0.1))
                make.width.equalTo()(CGFloat(self.bounds.size.width * 0.8))
                make.height.equalTo()(CGFloat(45))
            }

            //password
            self.addSubview(passwordTextField)
            passwordTextField.delegate = self
            passwordTextField.returnKeyType = UIReturnKeyType.Done
            passwordTextField.placeholder = "  请输入密码"
            passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
            passwordTextField.secureTextEntry = true
            passwordTextField.mas_makeConstraints { make in
                make.top.equalTo()(self.accountTextField.mas_bottom).with().offset()(CGFloat(10))
                make.left.equalTo()(self.mas_left).with().offset()(CGFloat(self.bounds.size.width * 0.1))
                make.width.equalTo()(CGFloat(self.bounds.size.width * 0.8))
                make.height.equalTo()(CGFloat(45))
            }


            //loginButton
            self.addSubview(loginButton)
            loginButton.setTitle("登陆奶牛", forState: UIControlState.Normal)
            loginButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            loginButton.setBackgroundImage(UIImage(named: "button"), forState: UIControlState.Normal)
//            loginButton.addTarget(self.loginButton, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
            loginButton.mas_makeConstraints { make in
                make.top.equalTo()(self.passwordTextField.mas_bottom).with().offset()(CGFloat(40))
                make.left.equalTo()(self.mas_left).with().offset()(CGFloat(self.bounds.size.width * 0.1))
                make.width.equalTo()(CGFloat(self.bounds.size.width * 0.8))
                make.height.equalTo()(CGFloat(50))
            }

            //notGetAccount
            self.addSubview(notGetAccount)
            notGetAccount.text = "还没有奶牛账号?"
            notGetAccount.font = UIFont(name: "Arial", size: CGFloat(12))
            notGetAccount.mas_makeConstraints { make in
                make.top.equalTo()(self.loginButton.mas_bottom).with().offset()(CGFloat(10))
                make.left.equalTo()(self.mas_left).with().offset()(CGFloat(self.bounds.size.width * 0.1))
            }

            //regist
            self.addSubview(regist)
            regist.text = "免费注册"
            regist.font = UIFont(name: "Arial", size: CGFloat(12))
            regist.textColor = labelColor
            regist.mas_makeConstraints { make in
                make.top.equalTo()(self.loginButton.mas_bottom).with().offset()(CGFloat(10))
                make.left.equalTo()(self.notGetAccount.mas_right).with().offset()(CGFloat(self.bounds.size.width * 0.05))
            }
            
            //forgetPassword
            self.addSubview(forgetPassword)
            forgetPassword.text = "忘记密码?"
            forgetPassword.font = UIFont(name: "Arial", size: CGFloat(12))
            forgetPassword.textColor = labelColor
            forgetPassword.mas_makeConstraints { make in
                make.top.equalTo()(self.loginButton.mas_bottom).with().offset()(CGFloat(10))
                make.right.equalTo()(self.mas_right).with().offset()(CGFloat(-self.bounds.size.width * 0.1))
            }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //键盘监听 收起键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case accountTextField:
            accountTextField.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        default: return true
        }
    }
    //任意背景取消键盘
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent?) {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.becomeFirstResponder()
    }

}