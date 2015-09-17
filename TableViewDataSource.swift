//
//  TabelViewDataSource.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/17.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import Foundation

class TableViewDataSource : NSObject {
    
    var cellName: String?
    var cellImage: String?
    
    init(cellName: String?, cellImage:String) {
        super.init()
        self.cellName = cellName
        self.cellImage = cellImage
    }
}