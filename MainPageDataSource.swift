//
//  MainPageDataSource.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/25.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import Foundation

class MainPageDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var dataSource = [CellData]()  //db数据
    var reuseIdentifier: String = "main page identifier"  //重用符
    var db: DataSource!
    
    //初始化打开db并查询数据
    override init() {
        super.init()
        updateData()
    }
    func updateData() {
        db = DataSource()
        dataSource = [CellData]()
        let dataBase = db.OpenDataBase()
        let querySql = "select * from items"
        let dataList = dataBase.executeQuery(querySql, withArgumentsInArray: nil)
        //如果没有表, 则创建表
        if dataList == nil {
            let sql2 = "create table items(ID INT, items text)"
            dataBase.executeUpdate(sql2, withArgumentsInArray: nil)
        }else {
            //在表中获取数据
            while dataList.next() {
                dataSource.append(CellData(id: dataList.intForColumn("id"), item: dataList.stringForColumn("items")))
            }
        }
        dataBase.close()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //根据不同section配置cell内容
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as? MainPageCell
        print("cell = ")
        println(cell?.cellName?.text)
        let datacell = dataSource[indexPath.row]
        print("datacell = ")
        println(datacell.item)
        var cellimage = "cellImage"
        cell?.cellName?.text = ""
        cell!.configureCell(datacell.item, cellImage: "cellImage", cellId: datacell.id)
        return cell!
    }
    //设置section标题
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "功能测试"
    }
    //设置section footer
//    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "加载更多"
//    }
    //删除行
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var cell = dataSource[indexPath.row]
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print("删除cell")
            println(cell.item)
            let database = db.OpenDataBase()
            let delsql = "delete from items where items = '\(cell.item)'"
            if database.executeUpdate(delsql, withArgumentsInArray: nil) {
                //删除数据源的对应数据
                println(dataSource[indexPath.row])
                dataSource.removeAtIndex(indexPath.row)
                //删除对应的cell
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
                
                //tableView.reloadData()  无动画效果
            }else {
                println("删除失败")
            }
        } else if editingStyle == UITableViewCellEditingStyle.Insert {
            println("insert")
        }
    }
}













