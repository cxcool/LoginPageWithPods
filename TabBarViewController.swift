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
        
        //设置tabBar的tab
        page1 = Page1ViewController()
        page1?.tabBarItem.title = "page1"
        page1?.tabBarItem.image = UIImage(named: "itempage1")
        
        page2 = Page2ViewController()
        page2?.tabBarItem.title = "page2"
        page2?.tabBarItem.image = UIImage(named: "itempage2")
        
        var pages = [page1!, page2!]
        //self.viewControllers = pages
        self.setViewControllers(pages, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
























