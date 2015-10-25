//
//  ChatListDataSource.swift
//  CowPlan
//
//  Created by 菜 on 15/10/19.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class ChatListDataSource: NSObject, UITableViewDataSource {
    
    var chatList: NSArray = []
    var reuseIdentifier: String = "ChatListIdentifier"  //重用符
    
    override init() {
        super.init()
        
        //getConversation()
    }
    func getConversation() {
        JMSGConversation.getConversationListWithCompletionHandler { (res, error) -> Void in
            if error == nil {
                self.chatList = res as! NSArray
            }else {
                self.chatList = []
            }
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return chatList.count
        return chatList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        let chat = chatList[indexPath.row] as? String
        cell.textLabel?.text = chat
        return cell
    }
}
