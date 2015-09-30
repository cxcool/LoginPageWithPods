//
//  TabBarViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/22.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var page1: Page1ViewController?
    var page2: Page2ViewController?
    
//    var label1: UILabel?
//    var label2: UILabel?
//    
//    var segControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        label1 = UILabel(frame: CGRectMake(0, 300, 200, 200))
//        label1?.text = "label1"
//        self.view.addSubview(label1!)
//        
//        label2 = UILabel(frame: CGRectMake(0, 300, 200, 200))
//        label2?.text = "label2"
//        self.view.addSubview(label2!)
//        label2?.hidden = true
        
        
//        var items: [String] = ["朋友", "群", "设置"]
//        //segControl.setTitle("朋友", forSegmentAtIndex: 0)
//        //segControl.setTitle("群", forSegmentAtIndex: 1)
//        //segControl.insertSegmentWithTitle("什么", atIndex: 1, animated: true)  增加一个
//        segControl = UISegmentedControl(items: items)
//        segControl.selectedSegmentIndex = 0
//        segControl.addTarget(self, action: "changeSeg", forControlEvents: UIControlEvents.ValueChanged)
//        self.view.addSubview(segControl)
//        segControl.mas_makeConstraints {
//            make in
//            make.top.equalTo()(self.view.mas_top).with().offset()(CGFloat(70))
//            make.centerX.equalTo()(self.view.mas_centerX)
//            make.width.equalTo()(CGFloat(180))
//        }
        
        //设置tabBar的tab
        page1 = Page1ViewController()
        page1?.tabBarItem.title = "page1"
        page1?.tabBarItem.image = UIImage(named: "itempage1")
        
        page2 = Page2ViewController()
        page2?.tabBarItem.title = "page2"
        page2?.tabBarItem.image = UIImage(named: "itempage2")
        
        var pages = [page1!, page2!]
        self.viewControllers = pages
        self.setViewControllers(pages, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func changeSeg() {
//        println(segControl.selectedSegmentIndex)
//        switch segControl.selectedSegmentIndex {
//        case 0:
//            label1?.hidden = false
//            label2?.hidden = true
//        case 1:
//            label1?.hidden = true
//            label2?.hidden = false
//        default:
//            label1?.hidden = true
//            label2?.hidden = true
//        }
//    }
}
























