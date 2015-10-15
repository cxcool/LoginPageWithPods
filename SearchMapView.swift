//
//  SearchMapView.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/10/12.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class SearchMapView: UIView {
    
    var viewSearch: UIView? //地图上搜索, 定位标签等的显示
    
    var labelLocation: UILabel? //搜索位置标签
    var textfieldLocation: UITextField? //搜索位置输入框
    var buttonLocationOk: UIButton? //搜索位置确定按钮
    
    var labelAround: UILabel? //搜索附近标签
    var textfieldAround: UITextField? //搜索附近输入框
    var buttonAroundOk: UIButton? //搜索附近确定按钮
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //初始化viewSearch
        viewSearch = UIView(frame: CGRectMake(0, 0, self.bounds.width, 60))
        viewSearch?.backgroundColor = UIColor.whiteColor()
        self.addSubview(viewSearch!)
        //搜索位置标签
        labelLocation = UILabel()
        labelLocation?.text = "搜地方"
        viewSearch?.addSubview(labelLocation!)
        labelLocation?.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(80))
            make.height.equalTo()(CGFloat(30))
            make.leading.equalTo()(self.viewSearch?.mas_leading).with().offset()(CGFloat(30))
            make.top.equalTo()(self.viewSearch?.mas_top)
        }
        //搜索输入框
        textfieldLocation = UITextField()
        //textfieldLocation?.delegate = self
        textfieldLocation?.placeholder = "输入查询位置"
        textfieldLocation?.borderStyle = UITextBorderStyle.RoundedRect
        viewSearch?.addSubview(textfieldLocation!)
        textfieldLocation?.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(180))
            make.height.equalTo()(CGFloat(30))
            make.leading.equalTo()(self.labelLocation?.mas_trailing)
            make.top.equalTo()(self.viewSearch?.mas_top)
        }
        //初始化定位按钮
        buttonLocationOk = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        buttonLocationOk?.setTitle("GO", forState: UIControlState.Normal)
        //buttonLocationOk?.addTarget(self, action: "locationToChongqing", forControlEvents: UIControlEvents.TouchUpInside)
        viewSearch?.addSubview(buttonLocationOk!)
        buttonLocationOk?.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(80))
            make.height.equalTo()(CGFloat(30))
            make.leading.equalTo()(self.textfieldLocation?.mas_trailing)
            make.top.equalTo()(self.viewSearch?.mas_top)
        }
        //搜索附近标签
        labelAround = UILabel()
        labelAround?.text = "搜附近"
        viewSearch?.addSubview(labelAround!)
        labelAround?.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(80))
            make.height.equalTo()(CGFloat(30))
            make.leading.equalTo()(self.viewSearch?.mas_leading).with().offset()(CGFloat(30))
            make.bottom.equalTo()(self.viewSearch?.mas_bottom)
        }
        //搜索附近输入框
        textfieldAround = UITextField()
        //textfieldAround?.delegate = self
        textfieldAround?.placeholder = "输入附近位置"
        textfieldAround?.borderStyle = UITextBorderStyle.RoundedRect
        viewSearch?.addSubview(textfieldAround!)
        textfieldAround?.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(180))
            make.height.equalTo()(CGFloat(30))
            make.leading.equalTo()(self.labelAround?.mas_trailing)
            make.bottom.equalTo()(self.viewSearch?.mas_bottom)
        }
        //初始化附近按钮
        buttonAroundOk = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        buttonAroundOk?.setTitle("GO", forState: UIControlState.Normal)
        //buttonAroundOk?.addTarget(self, action: "locationToChongqing", forControlEvents: UIControlEvents.TouchUpInside)
        viewSearch?.addSubview(buttonAroundOk!)
        buttonAroundOk?.mas_makeConstraints {
            make in
            make.width.equalTo()(CGFloat(80))
            make.height.equalTo()(CGFloat(30))
            make.leading.equalTo()(self.textfieldAround?.mas_trailing)
            make.bottom.equalTo()(self.viewSearch?.mas_bottom)
        }

    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //任意背景取消键盘
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent?) {
        textfieldLocation!.resignFirstResponder()
        textfieldAround!.resignFirstResponder()
        self.becomeFirstResponder()
    }

}
