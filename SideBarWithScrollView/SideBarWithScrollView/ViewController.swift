//
//  ViewController.swift
//  SideBarWithScrollView
//
//  Created by DangGu on 15/9/15.
//  Copyright © 2015年 Donggu. All rights reserved.
//

import UIKit

struct Picture {
    var imageTitle: String
    var imageName : String
}

let imageCellIdentifier = "imageCell"
class ViewController: UIViewController {
    
    var dataArray: [Picture]!
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = UIColor(red: 195/255.0, green: 112/255.0, blue: 112/255.0, alpha: 1.0)
            tableView.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "エリザベス"
        dataArray = []
        for i in 0...4 {
            let picture: Picture = Picture(imageTitle: "伊丽莎白酱 \(i)", imageName: "yilishabai_\(i+1)")
            dataArray.append(picture)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray == nil ? 0 : dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(imageCellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        let picture = dataArray[indexPath.row]
        cell.titleLabel.text = picture.imageTitle
        cell.avatarImageView.image = UIImage(named: picture.imageName)
        return cell
    }
    
}
extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}