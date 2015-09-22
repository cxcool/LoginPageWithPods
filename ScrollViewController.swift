//
//  ScrollViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/21.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    var imageView: UIImageView!
    var imageView2: UIImageView!
    var sview: UIScrollView!
    var pControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化组件
        sview = UIScrollView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        pControl = UIPageControl(frame: CGRectMake(self.view.bounds.width * 0.5 - 20, self.view.bounds.height - 40, 40, 20))
        
        //初始化图片
        imageView = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        imageView2 = UIImageView(frame: CGRectMake(self.view.bounds.width, 0, self.view.bounds.width, self.view.bounds.height))
        imageView.image = UIImage(named: "sv2")
        imageView2.image = UIImage(named: "sv2")
        
        //设置scroll
        sview.addSubview(imageView)
        sview.addSubview(imageView2)
        sview.contentSize = CGSizeMake(imageView.bounds.width + imageView2.bounds.width, 0) //只能水平滚动
        sview.pagingEnabled = true  //整页翻动
        sview.showsHorizontalScrollIndicator = false //隐藏水平滚动条
        sview.delegate = self
        sview.bounces = true //边缘弹动效果
        self.view.addSubview(sview)
        
        //设置pagecontrol
        pControl.currentPage = 0
        pControl.numberOfPages = 2
        self.view.addSubview(pControl)
    }
    
    //scrollview代理函数
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let sviewW = sview.frame.size.width
        let currentpage = Int((sview.contentOffset.x + CGFloat(sviewW / 2)) / sviewW)
        pControl.currentPage = currentpage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
























