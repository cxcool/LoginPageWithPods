//
//  CollectionViewLayout.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/21.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class CollectionViewLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.minimumInteritemSpacing = 0 //每个cell的间距
        self.itemSize = CGSizeMake(90,  90) //每一个cell内容的大小
        self.scrollDirection = UICollectionViewScrollDirection.Vertical //垂直滑动排列
        self.sectionInset = UIEdgeInsetsMake(5, 5, 0, 0) //
        //self.minimumLineSpacing = 0
        self.headerReferenceSize = CGSizeMake(0,20)
        self.footerReferenceSize = CGSizeMake(0, 20)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
