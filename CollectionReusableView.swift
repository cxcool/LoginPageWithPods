//
//  CollectionReusableView.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/22.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    var headView: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        headView = UILabel(frame: CGRectMake(0, 0, self.bounds.width, 20))
        headView?.text = "header"
        headView?.textAlignment = NSTextAlignment.Center
        self.addSubview(headView!)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
