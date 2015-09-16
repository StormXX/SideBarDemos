//
//  SideBarViewController.swift
//  SideBarWithScrollView
//
//  Created by DangGu on 15/9/15.
//  Copyright © 2015年 Donggu. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController {
    
    var leftViewController: UIViewController!
    var mainViewController: UIViewController!
    var scrollView: UIScrollView!
    
    var overlap: CGFloat = 0.0
    
    init(leftViewController: UIViewController, mainViewController: UIViewController, overlap: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        self.leftViewController = leftViewController
        self.mainViewController = mainViewController
        self.overlap = overlap
        view.backgroundColor = UIColor.blackColor()
        setupScrollView()
        setupViewControllers()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - private method
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView":scrollView])
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView":scrollView])
        NSLayoutConstraint.activateConstraints(horizontalConstraints + verticalConstraints)
    }
    
    func setupViewControllers() {
        addViewController(leftViewController)
        addViewController(mainViewController)
        
        let views = ["left": leftViewController.view, "main": mainViewController.view, "outer": scrollView]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[left][main(==outer)]|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[main(==outer)]|", options: [], metrics: nil, views: views)
        let leftViewControllerWidthConstraints = NSLayoutConstraint(
            item: leftViewController.view,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Width,
            multiplier: 1.0,
            constant: -overlap)
        NSLayoutConstraint.activateConstraints(horizontalConstraints + verticalConstraints + [leftViewControllerWidthConstraints])
    }
    
    func addViewController(viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewController.view)
        addChildViewController(viewController)
        viewController.didMoveToParentViewController(self)
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
