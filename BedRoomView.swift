//
//  BedRoomView.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/17.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Masonry

class BedRoomView: UIView {
    
    var bedRommView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bedRommView = UIImageView()
        bedRommView.image = UIImage(named: "bedRoom")
        bedRommView.backgroundColor = UIColor.grayColor()
        self.addSubview(bedRommView)
        bedRommView.mas_makeConstraints {
            make in
            make.top.equalTo()(self.mas_top)
            make.left.equalTo()(self.mas_left)
            make.right.equalTo()(self.mas_right)
            make.bottom.equalTo()(self.mas_bottom)
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
