//
//  AddCellView.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/25.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Masonry

class AddCellView: UIView, UITextFieldDelegate {
    
    var item: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        item = UITextField()
        item.borderStyle = UITextBorderStyle.RoundedRect
        item.returnKeyType = UIReturnKeyType.Done
        item.delegate = self
        self.addSubview(item)
        self.backgroundColor = UIColor.whiteColor()
        item.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(150))
            make.height.equalTo()(CGFloat(30))
            make.centerX.equalTo()(self.mas_centerX)
            make.top.equalTo()(self.mas_top).with().offset()(CGFloat(90))
        }
        item.placeholder = "输入功能名称"
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //键盘监听 收起键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        item.resignFirstResponder()
        self.becomeFirstResponder()
        return true
    }
    //任意背景取消键盘
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent?) {
        item.resignFirstResponder()
        self.resignFirstResponder()
    }
}
