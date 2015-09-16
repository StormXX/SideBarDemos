//
//  ViewController.swift
//  UberSideBar
//
//  Created by DangGu on 15/9/16.
//  Copyright © 2015年 Donggu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var uberSideBarViewController: UberSideBarViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 244.0/255.0, green: 240.0/255.0, blue: 215.0/255.0, alpha: 1.0)
        
        uberSideBarViewController = UberSideBarViewController()
        view.addSubview(uberSideBarViewController.view)
        addChildViewController(uberSideBarViewController)
        uberSideBarViewController.didMoveToParentViewController(self)
        uberSideBarViewController.addGesture()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

