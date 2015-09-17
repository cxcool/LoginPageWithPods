//
//  WebViewPage.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/14.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Alamofire

class WebViewPage: UIView {
    var webView: UIWebView = UIWebView() //需要显示的网页
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadWebView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //网页布局
    func loadWebView() {
        //webView.scalesPageToFit = true
        self.addSubview(webView)
        webView.mas_makeConstraints { make in
            make.top.equalTo()(self.mas_top).with().offset()(CGFloat(20))
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.bottom.equalTo()(self.mas_bottom)
        }
    }
}
