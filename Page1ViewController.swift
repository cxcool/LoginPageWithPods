//
//  Page1ViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/22.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class Page1ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //日期选择器
    var datePicker: UIDatePicker!
    var buttonDate: UIButton?
    
    //省级联动选择器
    var pickView: UIPickerView?
    var buttonPicker: UIButton?
    var countrys: [String] = [] //国家数据 一级
    var cities: [String] = [] //城市数据 二级
    var district: [String] = [] //区数据 三级
    var locationCountry: NSDictionary! //国家字典
    var locationCity: NSDictionary? //城市字典
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        //从Location.plist读取数据
        if let bundlePath:String = NSBundle.mainBundle().pathForResource("Location", ofType: "plist") {
            let country = NSMutableDictionary(contentsOfFile: bundlePath)!
            if let isNotNillocationCountry: NSDictionary? = country.objectForKey("Country") as? NSDictionary {
                locationCountry = isNotNillocationCountry! //国家字典初始化
                //初始化
                countrys = (locationCountry.allKeys as? [String])!
                cities = (locationCountry.objectForKey(countrys[0])?.allKeys as? [String])!
                district = (locationCountry.objectForKey(countrys[0])?.objectForKey(cities[0]) as? [String])!
                locationCity = locationCountry.objectForKey(countrys[0]) as? NSDictionary //城市字典初始化
                println(locationCity)
            }
        }
        
        //日期选择器
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.minuteInterval = 10
        //datePicker.backgroundColor = UIColor.grayColor()
        self.view.addSubview(datePicker)
        datePicker.mas_makeConstraints {
            make in
            make.top.equalTo()(self.view.mas_top).with().offset()(CGFloat(70))
            make.width.equalTo()(self.view.mas_width)

        }
        buttonDate = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        //buttonDate?.frame = CGRectMake(100, 320, 220, 20)
        buttonDate?.setTitle("日期选择", forState: UIControlState.Normal)
        buttonDate?.addTarget(self, action: "showDate", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buttonDate!)
        buttonDate?.mas_makeConstraints {
            make in
            make.top.equalTo()(self.datePicker.mas_bottom).with().offset()(CGFloat(5))
            make.centerX.equalTo()(self.view.mas_centerX)
        }
        
        //PickerView选择器
        pickView = UIPickerView()
        pickView?.dataSource = self
        pickView?.delegate = self
        //pickView?.selectRow(2, inComponent: 0, animated: true)
        self.view.addSubview(pickView!)
        pickView?.mas_makeConstraints {
            make in
            make.top.equalTo()(self.buttonDate?.mas_bottom).with().offset()(CGFloat(5))
            make.centerX.equalTo()(self.view.mas_centerX)
        }
        buttonPicker = UIButton.buttonWithType(UIButtonType.System) as? UIButton
        //buttonPicker?.frame = CGRectMake(60, 340, 200, 20)
        buttonPicker?.setTitle("地区选择", forState: UIControlState.Normal)
        buttonPicker?.addTarget(self, action: "showContent", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(buttonPicker!)
        buttonPicker?.mas_makeConstraints {
            make in
            make.top.equalTo()(self.pickView?.mas_bottom)
            make.centerX.equalTo()(self.view.mas_centerX)
        }
    }
    //日期选择按钮
    func showDate() {
        println(datePicker.date)
        //self.navigationController?.pushViewController(Page2ViewController(), animated: true)
    }
    //picker按钮
    //实现datasource协议, 规定行列
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return countrys.count
        case 1: return cities.count
        case 2: return district.count
        default: return 0
        }
    }
    //3列
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    //实现delegate协议,填充数据
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch component {
        case 0:
            return countrys[row] //国家数据 locationCountry.allKeys[row] as! String
        case 1:
            return cities[row]
        case 2:
            return district[row]
        default: break
        }
        return "unkonw"
    }
    //联动
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println(row)
        switch component {
        case 0:
            cities = (locationCountry.objectForKey(countrys[row])?.allKeys as? [String])!
            district = (locationCountry.objectForKey(countrys[row])?.objectForKey(cities[0]) as? [String])! //最后一级不用.allkey/value
            locationCity = locationCountry.objectForKey(countrys[row]) as? NSDictionary
            println(locationCity)
            // 重新加载二级选项并复位
            pickView?.reloadComponent(1)
            pickView?.reloadComponent(2)
            pickView?.selectRow(0, inComponent: 1, animated: true)
        case 1:
           // println(countrys[row])
            println(cities[row])
            district = (locationCity?.objectForKey(cities[row]) as? [String])!
            // 重新加载三级选项并复位
            pickView?.reloadComponent(2)
            pickView?.selectRow(0, inComponent: 2, animated: true)
        default: break
        }
    }
    func showContent () {
        println(pickView?.selectedRowInComponent(0))
        println(pickView?.selectedRowInComponent(1))
        println(pickView?.selectedRowInComponent(2))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
