//
//  BedRoomViewController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/17.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class BedRoomViewController: UIViewController {

    var bedroomView: BedRoomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bedroomView = BedRoomView(frame: CGRectMake(0, 20, self.view.bounds.width, self.view.bounds.height))
        self.view.addSubview(bedroomView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
