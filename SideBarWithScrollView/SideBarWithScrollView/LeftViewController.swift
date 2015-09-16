//
//  LeftViewController.swift
//  SideBarWithScrollView
//
//  Created by DangGu on 15/9/15.
//  Copyright © 2015年 Donggu. All rights reserved.
//

import UIKit

let catogaryCellIdentifier = "catogaryCell"
class LeftViewController: UIViewController {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor(red: 255.0/255.0, green: 191.0/255.0, blue: 0, alpha: 1.0)
            tableView.tableFooterView = UIView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "类别"
        // Do any additional setup after loading the view.
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

extension LeftViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(catogaryCellIdentifier, forIndexPath: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "エリザベス"
        } else {
            cell.textLabel?.text = "さだはる"
        }
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
}
extension LeftViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}