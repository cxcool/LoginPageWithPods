//
//  ChatListController.swift
//  CowPlan
//
//  Created by 菜 on 15/10/19.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class ChatListController: UITableViewController {

    var reuseIdentifier = "ChatListIdentifier"
    var datasource: ChatListDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = ChatListDataSource()
        self.tableView.dataSource = datasource
        //table样式
        self.tableView.scrollsToTop = true
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }
}
