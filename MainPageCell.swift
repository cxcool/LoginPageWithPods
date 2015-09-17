//
//  MainPageCell.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/17.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit
import Masonry

class MainPageCell: UITableViewCell {

    var cellName: UILabel?
    var cellImage: UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    //设置cell样式
    func configureCell(cell: String, cellImage:String) {
        
        //image
        self.cellImage = UIImageView(image: UIImage(named: cellImage))
        self.addSubview(self.cellImage!)
        self.cellImage!.mas_makeConstraints {
            make in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(CGFloat(15))
        }
        //label
        cellName = UILabel(frame: CGRectMake(15, 0, self.bounds.width, 50))
        cellName?.text = cell
        self.addSubview(cellName!)
        self.cellName?.mas_makeConstraints {
            make in
            make.centerY.equalTo()(self.mas_centerY)
            make.left.equalTo()(self.cellImage?.mas_right).with().offset()(CGFloat(10))
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
