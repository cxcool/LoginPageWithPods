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
    //var tableViewCell: MainPageCell!
    //数据源
    var dataSource: MainPageDataSource!
    //编辑按钮
    var rightBarButtonItem: UIBarButtonItem?
    //下拉刷新
    var rfControl: UIRefreshControl!
    //搜索框
    var searchBar: UISearchBar!
    //新增界面Controller
    var addView: AddCellView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Function Test"
        
        //导航按钮
        rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addCell")
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        //tableView样式
        self.tableView.registerClass(MainPageCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.tableView.scrollsToTop = true
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        //数据源--dataBase
        dataSource = MainPageDataSource()
        self.tableView.dataSource = dataSource
        //下拉刷新
        rfControl = UIRefreshControl()
        rfControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        rfControl.attributedTitle = NSAttributedString(string: "下拉刷新...")
        rfControl.tintColor = UIColor.redColor()
        self.view.addSubview(rfControl)
        refresh()
        //搜索栏
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        println(searchBar.bounds)
        searchBar.placeholder = "搜索功能"
        searchBar.showsScopeBar = true
        self.tableView.addSubview(searchBar)
        self.tableView.tableHeaderView = searchBar
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //顶部搜索条   每次搜索内容时会调用
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //some code there
        println("search")
    }
    //点击cell事件
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cellname = self.dataSource.dataSource[indexPath.row]
        print("点击cell")
        println(cellname.item)
        switch cellname.item {
        case "Collection":
            var flowLayout = CollectionViewLayout()
            var cview = CollectionViewController(collectionViewLayout: flowLayout)
            self.navigationController?.pushViewController(cview, animated: true)
        case "滑动页面":
            var sview = ScrollViewController()
            self.navigationController?.pushViewController(sview, animated: true)
        case "segmentBar":
            var tabbar = TabBarViewController()
            self.navigationController?.pushViewController(tabbar, animated: true)
        case "扫码":
            var qrView = QRScanController()
            self.navigationController?.pushViewController(qrView, animated: true)
        case "生成二维码":
            var qrImage = QRCreateViewController()
            self.navigationController?.pushViewController(qrImage, animated: true)
        case "notification":
            var notification = NotificationViewController()
            self.navigationController?.pushViewController(notification, animated: true)
        case "weixin":
            var weixin = WeiXinViewController()
            self.navigationController?.pushViewController(weixin, animated: true)

        default: break
        }
    }
    //新增cell
    func addCell() {
        addView = AddCellView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        var addCrl = UIViewController()
        addCrl.view = addView
        self.navigationController?.pushViewController(addCrl, animated: true)
        rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "addCellSave")
        addCrl.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    //保存新增cell
    func addCellSave() {
        var db = DataSource()
        let database = db.OpenDataBase()
        let number = rand()
        let addsql = "insert into items (ID, items) values ('\(number)', '\(addView!.item.text)')"
        if database.executeUpdate(addsql, withArgumentsInArray: nil) {
            var cellNumber = dataSource.dataSource.count
            var indexpath = NSIndexPath(forRow: cellNumber, inSection: 0)
            dataSource.dataSource.append(CellData(id: number, item: addView!.item.text))
            tableView.insertRowsAtIndexPaths([indexpath], withRowAnimation: UITableViewRowAnimation.Automatic)
            //tableView.reloadRowsAtIndexPaths([indexpath], withRowAnimation: UITableViewRowAnimation.Bottom)
            //tableView.reloadData() 无动画效果
            self.navigationController?.popViewControllerAnimated(true)
        }else {
            println("新增失败")
        }
    }
    //下拉刷新
    func refresh() {
        if self.rfControl.refreshing == true{
            self.rfControl.attributedTitle = NSAttributedString(string: "获取数据中...")
        }
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            sleep(1)
            self.dataSource.updateData()
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
            for index in self.dataSource.dataSource {
                print("下拉cell = ")
                println(index.item)
            }
            self.rfControl.endRefreshing()
            self.rfControl.attributedTitle = NSAttributedString(string: "下拉刷新...")
        })
        
    }
}



























