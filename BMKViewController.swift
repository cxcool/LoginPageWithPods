//
//  BMKViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/10/10.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class BMKViewController: UIViewController, BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, BMKPoiSearchDelegate, UITextFieldDelegate {

    var mapView: BMKMapView! //百度地图view
    var searchView: SearchMapView! //地图上的搜索视图
    var locationService: BMKLocationService? //百度地图服务
    var annotationBJ: BMKPointAnnotation? //北京  标注
    var searcher: BMKGeoCodeSearch = BMKGeoCodeSearch() //geo检索
    var searchNearby: BMKPoiSearch = BMKPoiSearch() //搜索附近
    var annotationAround: BMKPoiResult? //附近搜索结果标注数据
    var annotationLocation: BMKReverseGeoCodeResult? //地名搜索标注结果
    var annotationArray: [BMKPointAnnotation]? //标注数组
    var searchLocationResult: BMKReverseGeoCodeResult? //地名-->坐标-->地名详细信息
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化一个百度地图view
        mapView = BMKMapView(frame: self.view.frame)
        self.view.addSubview(mapView)
        //初始化viewSearch
        searchView = SearchMapView(frame: CGRectMake(0, 64, self.view.bounds.width, 60))
        searchView.buttonAroundOk?.addTarget(self, action: "searchAround", forControlEvents: UIControlEvents.TouchUpInside)
        searchView.buttonLocationOk?.addTarget(self, action: "searchLocation", forControlEvents: UIControlEvents.TouchUpInside)
        searchView.textfieldAround?.delegate = self
        searchView.textfieldLocation?.delegate = self
        self.view.addSubview(searchView)
        //初始化地图服务
        BMKLocationService.setLocationDesiredAccuracy(kCLLocationAccuracyBest) //设置精度  默认最高精度(除了导航之外)
        BMKLocationService.setLocationDistanceFilter(10)  //设置最小距离更新
        locationService = BMKLocationService() //初始化locationservice
        //刷新用户位置
        mapView.updateLocationData(locationService?.userLocation)
        if locationService?.startUserLocationService() != nil {
            mapView.showsUserLocation = false
            mapView.userTrackingMode = BMKUserTrackingModeFollow //设置位置跟踪态
            mapView.showsUserLocation = true //显示定位图层
        }
    }
    //搜素附近的地方
    func searchAround() {
        let key = (searchView.textfieldAround?.text)!
        if locationService?.userLocation.location != nil {
            let coordinate = (locationService?.userLocation.location.coordinate)!
            searchAround(key, coordinate: coordinate) //搜索key并标注在地图上
        }else {
            println("位置获取失败")
        }
    }
    //搜索位置
    func searchLocation() {
        let key = (searchView.textfieldLocation?.text)!
        searchWithLocationName(key)
    }
    //实现相关delegate 处理位置信息更新
    //处理方向变更信息
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        println("didUpdateUserHeading")
        mapView.updateLocationData(userLocation)
    }
    //处理位置坐标更新
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        println(userLocation.location.coordinate.latitude)
        mapView.updateLocationData(userLocation)
        setCenterWithCoordinate(userLocation.location.coordinate)
    }
    //设置中心点
    func setCenterWithCoordinate(coordinate: CLLocationCoordinate2D) {
        //mapView.setCenterCoordinate(coordinate, animated: true)
        var viewRegion: BMKCoordinateRegion = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.07, 0.07))
        var adjustRegion: BMKCoordinateRegion = mapView.regionThatFits(viewRegion)
        mapView.setRegion(adjustRegion, animated: true)
    }
    //检索地名 位置-->坐标  执行这个func后会自动调用 onGetReverseGeoCodeResult
    func searchWithLocationName(location: String) {
        //var geoCodeSearchOption: BMKGeoCodeSearchOption = BMKGeoCodeSearchOption()
        var geoCodeSearchOption: BMKGeoCodeSearchOption = BMKGeoCodeSearchOption()
        geoCodeSearchOption.address = location
        var flag: Bool = searcher.geoCode(geoCodeSearchOption)
        if flag {
            println("geo检索发送成功")
        }else {
            println("geo检索发送失败")
        }
    }
    //接受反向地理编码结果
    func onGetGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if error.value == 0 {
            //设置中心点
            setCenterWithCoordinate(result.location)
            if let key = searchView.textfieldLocation?.text {
                searchAround(key, coordinate: result.location)
            }
        }else {
            println("未找到结果geo")
        }
    }
    //检索坐标 坐标-->位置名称  执行这个func后会自动调用 onGetReverseGeoCodeResult
    func searchWithCoordinate(coordinate: CLLocationCoordinate2D) {
        //var geoCodeSearchOption: BMKGeoCodeSearchOption = BMKGeoCodeSearchOption()
        var reverseGeoCodeSearchOption: BMKReverseGeoCodeOption = BMKReverseGeoCodeOption()
        reverseGeoCodeSearchOption.reverseGeoPoint = coordinate
        var flag: Bool = searcher.reverseGeoCode(reverseGeoCodeSearchOption)
        if flag {
            println("reverseGeo检索发送成功")
        }else {
            println("reverseGeo检索发送失败")
        }
    }
    //接受反向地理编码结果
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if error.value == 0 {
            if result != nil {
                for index in result.poiList {
                    println(index.name)
                }
            }
        }else {
            println("未找到结果reverseGeo")
        }
    }
    //检索周边网吧,小吃,唱歌等信息  执行这个func后会自动调用 onGetPoiResult
    func searchAround(keyword: String, coordinate: CLLocationCoordinate2D) {
        var option: BMKNearbySearchOption = BMKNearbySearchOption()
        option.pageIndex = 0
        //option.radius = 8000
        option.pageCapacity = 10
        option.location = coordinate
        option.keyword = keyword
        var flag: Bool = searchNearby.poiSearchNearBy(option)
        if flag {
            println("搜索附近发送成功")
        }else {
            println("搜索附近发送失败")
        }
    }
    //接受检索周边信息结果
    func onGetPoiResult(searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        if errorCode.value == 0 {
            annotationAround = poiResult //赋值annotation数据
            annotationWithAround(annotationAround!) //设置annotaiton标注
            //-----test--------------------
            var n = 1
            println("搜索附近成功")
            println(poiResult.totalPoiNum)
            println(poiResult.currPoiNum)
            println(poiResult.pageNum)
            println(poiResult.pageIndex)
            println(poiResult.poiInfoList)
            println(poiResult.cityList)
            for index in poiResult.poiInfoList {
                println("----------\(n)")
                println(index.name)
                println(index.address as String!)
                println(index.pt)
                n++
            }
            //-----test--------------------=
        }
    }
    //设置annotaiton标注
    func annotationWithAround(annotationData: BMKPoiResult!) {
        //清除标注
        if annotationArray != nil {
            mapView.removeAnnotations(annotationArray!)
            annotationArray = nil
        }
        annotationArray = [] //初始化annotation
        for index in annotationData.poiInfoList {
            var annotation: BMKPointAnnotation = BMKPointAnnotation()
            annotation.coordinate = index.pt
            annotation.title = index.name
            annotation.subtitle = index.address
            annotationArray?.append(annotation)
            mapView.addAnnotations(annotationArray!)
        }
    }
    //设置annotation样式
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if let annotation1 = annotation as? BMKPointAnnotation {
            var newAnnotationView: BMKPinAnnotationView = BMKPinAnnotationView(annotation: annotation1, reuseIdentifier: "reuseAnnotation")
            newAnnotationView.pinColor = UInt(BMKPinAnnotationColorRed)
            newAnnotationView.animatesDrop = true
            return newAnnotationView
        }
        return nil
    }
    //生命周期控制
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        mapView.delegate = self
        locationService?.delegate = self
        searcher.delegate = self
        searchNearby.delegate = self
    }
    override func viewDidAppear(animated: Bool) {
        //do something there...
    }
    override func viewWillDisappear(animated: Bool) {
        mapView.delegate = nil
        locationService?.delegate = nil
        searcher.delegate = nil
        searchNearby.delegate = nil
        locationService?.stopUserLocationService()
    }
    //键盘监听 收起键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case searchView.textfieldLocation!:
            searchView.textfieldLocation!.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        case searchView.textfieldAround!:
            searchView.textfieldAround!.resignFirstResponder()
            self.becomeFirstResponder()
            return true
        default: return true
        }
    }

}


























