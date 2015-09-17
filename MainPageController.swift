//
//  MainPageController.swift
//  LoginPageWithPods
//
//  Created by 菜 on 15/9/17.
//  Copyright (c) 2015年 菜. All rights reserved.
//

import UIKit

class MainPageController: UITableViewController {

    var data: [TableViewDataSource]!
    //var mainPageTableView: MainPageView!
    var reuseIdentifier: String = "main page identifier"
    var tableViewCell: MainPageCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Function Test"
        
        //表格数据
        data = [
            TableViewDataSource(cellName: "scrollPage", cellImage: "cellImage"),
            TableViewDataSource(cellName: "waiting...", cellImage: "cellImage"),
            TableViewDataSource(cellName: "waiting...", cellImage: "cellImage"),
            TableViewDataSource(cellName: "waiting...", cellImage: "cellImage"),
            TableViewDataSource(cellName: "waiting...", cellImage: "cellImage"),
            TableViewDataSource(cellName: "waiting...", cellImage: "cellImage"),
            TableViewDataSource(cellName: "waiting...", cellImage: "cellImage"),
            TableViewDataSource(cellName: "waiting...", cellImage: "cellImage"),
            TableViewDataSource(cellName: "waiting...", cellImage: "cellImage")
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> MainPageCell {
        
        var cell = MainPageCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        // Configure the cell...
        let datasource = data[indexPath.row]
        cell.configureCell(datasource.cellName!, cellImage: datasource.cellImage!)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
