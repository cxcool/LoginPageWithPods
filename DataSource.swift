//
//  DataSource.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/24.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import Foundation

class DataSource: NSObject {
    
    //开打数据库
    func OpenDataBase() -> FMDatabase {
        let documentsFolder: String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        let path = documentsFolder.stringByAppendingPathComponent("Training.sqlite")
        let dataBase = FMDatabase(path: path)
        if dataBase.open() {
            println(path)
        }else {
            println(dataBase.logsErrors)
        }
    return dataBase
    }
}
