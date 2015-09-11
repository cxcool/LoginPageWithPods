//
//  LoginModel.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/10.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginToGetResponse {
    var data = JsonData(error: nil, msg: nil, code: nil)
    //取得json数据并封装到JsonData类
    
    func webConnect(account: String, password: String, callback: ((isOK: Bool) -> Void)) {
        //网页请求
        let parameters = ["mobile": account, "password": password] //参数
        let url = "http://120.25.154.7/api-login"  //地址
        
        Alamofire.request(.POST, url, parameters: parameters)
            .responseJSON { (request, response, json, error) in
                if error == nil && json != nil {
                    var jsonData: JSON = []
                    jsonData = JSON(json!)
                    self.data.code = jsonData["code"].stringValue
                    self.data.msg = jsonData["msg"].stringValue
                    self.data.error = jsonData["error"].stringValue
                    callback(isOK: true)
                }else {
                    println("error:\(error!)")
                    callback(isOK: false)
                }
        }
    }
}

class JsonData {
    var error: String?
    var msg: String?
    var code: String?
    init(error:String?, msg:String?, code: String?) {
        self.msg = msg
        self.error = error
        self.code = code
    }
}

















