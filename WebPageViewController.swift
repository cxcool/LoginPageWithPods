//
//  WebPageViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/14.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import JavaScriptCore

class WebPageViewController: UIViewController, UIWebViewDelegate {

    var webPage: WebViewPage = WebViewPage()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化webPage
        var frame: CGRect = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        webPage = WebViewPage(frame: frame)
        webPage.webView.delegate = self
        //let url = NSURL(string: "/Users/cool/Work/webViewPage.html")
        let url = NSURL(string: "http://www.baidu.com")
        let urlRequest = NSURLRequest(URL: url!)
        webPage.webView.loadRequest(urlRequest)
        //增加返回手势
        var backGesture = UISwipeGestureRecognizer(target: self, action: "backToHomePage")
        self.view.addGestureRecognizer(backGesture)
        
        self.view.addSubview(webPage)
    }
    //滑动返回
    func backToHomePage() {
        //self.navigationController?.popToViewController(ViewController(), animated: true)
        self.presentViewController(ViewController(), animated: true, completion: nil)
    }
    //页面将要跳转时
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.URL?.scheme == "ios" {
            let result = webView.stringByEvaluatingJavaScriptFromString("getTextValue()")
            println("result:\(result!)")
            return true
        }else {
            println("首次载入")
            return true
        }
    }
    //页面加载完成
    func webViewDidFinishLoad(webView: UIWebView) {
        println("页面加载完成")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //顶部状态栏字体白色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
