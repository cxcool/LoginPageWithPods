//
//  QRScanController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/28.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import AVFoundation

class QRScanController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    var greenbar: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //需要以合适的AVCaptureDevice对象作为输入参数去实例化一个AVCaptureSession对象
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) //代表一个物理视频设备
        var error: NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        println(error)
        captureSession = AVCaptureSession()
        println("cd = \(captureDevice)")
        println("cd = \(input)")
        println("cd = \(captureSession)")
        
        if captureDevice != nil && input != nil {
            captureSession?.addInput(input as! AVCaptureInput)
            //输出
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            //设置代理, 新数据源捕获时使用此方法
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            //显示摄像头的图像
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer)
            //开启视频捕获
            captureSession?.startRunning()
            //将二维码用方框框起来
            qrCodeFrameView = UIView()
            qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
            qrCodeFrameView?.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView!)
            view.bringSubviewToFront(qrCodeFrameView!)
            //屏幕上显示上下移动的横条
            greenbar = UIImageView()
            greenbar?.image = UIImage(named: "")
            UIView.animateWithDuration(1, animations: { () -> Void in
                //动画效果
            })
        }else {
            var alert = UIAlertController(title: "错误", message: "没有摄像头或不允许访问相机", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "去设置", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: { msg in
                self.navigationController?.popViewControllerAnimated(true)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    //识别出二维码后调用方法
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            println("No QR code is detected")
            return
        }
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObjectTypeQRCode {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject =
            videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as!AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds;
            //扫码成功操作
            if metadataObj.stringValue != nil {
                println(metadataObj.stringValue)
                captureSession?.stopRunning()
            }
        }
        //通过调用viewPreviewLayer的transformedMetadataObjectForMetadataObject方法，元数据对象会被转化成图层的坐标。通过这个坐标可以获取二维码的边界并构建绿色方框。
        let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
        qrCodeFrameView?.frame = barCodeObject.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}





































