//
//  MainPageController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/17.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Masonry

class MainPageController: UITableViewController, UISearchBarDelegate {
    
    //cell重用identifier
    var reuseIdentifier: String = "main page identifier"
    var tableViewCell: MainPageCell!
    //数据源
    var list: NSMutableDictionary!
    var listKey = [String]() //存取listkey内容
    var listValue = [String]() //value
    //编辑按钮
    var rightBarButtonItem: UIBarButtonItem?
    var leftBarButtonItem: UIBarButtonItem?
    //下拉刷新
    var rfControl: UIRefreshControl!
    //搜索框
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Function Test"
        
        //导航按钮
        rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editCell")
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        //tableView样式
        self.tableView.registerClass(MainPageCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.scrollsToTop = true
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        //数据源
        var ban = NSBundle.mainBundle()
        if let plistPath = ban.pathForResource("TabelViewData", ofType: "plist") {
            list = NSMutableDictionary(contentsOfFile: plistPath)
            //遍历list, 存放内容到sec
            for index in list {
                listKey.insert(index.key as! (String), atIndex: 0)
                //listValue.insert(index.value as! (String), atIndex: 0)
            }
        }
        
        //下拉刷新
        rfControl = UIRefreshControl()
        rfControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        rfControl.attributedTitle = NSAttributedString(string: "下拉刷新...")
        rfControl.tintColor = UIColor.redColor()
        self.view.addSubview(rfControl)
        
        //搜索栏
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        println(searchBar.bounds)
        searchBar.placeholder = "搜索功能"
        searchBar.showsScopeBar = true
        self.tableView.addSubview(searchBar)
        self.tableView.tableHeaderView = searchBar
        println(self.searchBar.bounds.height)
        //self.tableView.contentOffset = CGPointMake(0, self.searchBar.bounds.height)
    }
    
    
    //顶部搜索条   每次搜索内容时会调用
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //some code there
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return list.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return list.objectForKey(listKey[section])?.count! ?? 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MainPageCell {
        
        /*  测试信息
        println("row=\(indexPath.row)")
        println("section=\(indexPath.section)")
        println("item=\(indexPath.item)")
        println(list.objectForKey(listKey[indexPath.section])!)
        */
        //根据不同section配置cell内容
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainPageCell
        var cellname: String = list.objectForKey(listKey[indexPath.section])![indexPath.row] as? String ?? ""
        var cellimage = "cellImage"
        cell.configureCell(cellname, cellImage: cellimage)
        return cell
    }
    
    //设置section标题
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listKey[section]
    }
    
    //点击cell事件
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cellname = list.objectForKey(listKey[indexPath.section])![indexPath.row] as? String ?? ""
        println(cellname)
        switch cellname {
            case "Collection":
                var flowLayout = CollectionViewLayout()
                var cview = CollectionViewController(collectionViewLayout: flowLayout)
                self.navigationController?.pushViewController(cview, animated: true)
            case "ScrollView":
                var sview = ScrollViewController()
                self.navigationController?.pushViewController(sview, animated: true)
            case "tab bar":
                var tabbar = TabBarViewController()
                self.navigationController?.pushViewController(tabbar, animated: true)
        default: break
        }
    }
    
    // Override to support editing the table view.   删除
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //重置barbutton
            rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "editCellSave")
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
            
            let key = listKey[indexPath.section]
            //let key = list.objectForKey(listKey[indexPath.section])[indexPath.row]
//            print("删除前:")
//            println(key)
//            list.removeObjectForKey(key)
//            print("删除后:")
//            println(list)
            // Delete the row from the data source
            //tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == UITableViewCellEditingStyle.Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
        }    
    }
    
    //cell的编辑状态
    func editCell() {
        self.tableView.setEditing(true, animated: true)
        println("开始修改")
        leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelEdit")
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    func editCellSave() {
        self.tableView.setEditing(false, animated: true)
        println("保存修改")
        self.navigationItem.leftBarButtonItem = nil
        rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editCell")
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    func cancelEdit() {
        println("cancel")
        self.tableView.setEditing(false, animated: true)
        self.navigationItem.leftBarButtonItem = nil
    }
    //刷新数据
    func refresh() {
        if self.rfControl.refreshing == true{
            self.rfControl.attributedTitle = NSAttributedString(string: "获取数据中...")
        }
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            sleep(2)
            self.rfControl.endRefreshing()
            self.rfControl.attributedTitle = NSAttributedString(string: "下拉刷新...")
            //self.tableView.reloadData()
        })
        
    }

}



























