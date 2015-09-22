//
//  CollectionViewCell.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/21.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame) //会被layout中的size覆盖
        
        self.backgroundColor = UIColor.grayColor()
        
        imageView = UIImageView()
        imageView.frame = CGRectMake(0, 0, 60, 60)
        imageView.image = UIImage(named: "collection")
        self.addSubview(imageView)
        imageView.mas_makeConstraints {
            make in
            make.center.equalTo()(self).centerOffset()(CGPointMake(0, -10))
        }
        
        label = UILabel(frame: CGRectMake(0, 0, 40, 10))
        label.text = "collection"
        label.textColor = UIColor.blackColor()
        self.addSubview(label)
        label.mas_makeConstraints{
            make in
            make.top.equalTo()(self.imageView.mas_bottom)
            make.centerX.equalTo()(self.imageView.mas_centerX)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
