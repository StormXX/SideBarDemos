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
    var firstTime: Bool = true
    
    init(leftViewController: UIViewController, mainViewController: UIViewController, overlap: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        self.leftViewController = leftViewController
        self.mainViewController = mainViewController
        self.overlap = overlap
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor()
        setupScrollView()
        setupViewControllers()
    }
    
    override func viewDidLayoutSubviews() {
        if firstTime {
            firstTime = false
            closeSideBar(false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - private setup method
    private func setupScrollView() {
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
    
    private func setupViewControllers() {
        addViewController(leftViewController)
        addViewController(mainViewController)
        
        addShadowToView(mainViewController.view)
        
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
    
    private func addViewController(viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewController.view)
        addChildViewController(viewController)
        viewController.didMoveToParentViewController(self)
    }
    
    private func addShadowToView(destView: UIView) {
        destView.layer.shadowPath = UIBezierPath(rect: destView.bounds).CGPath
        destView.layer.shadowRadius = 2.5
        destView.layer.shadowOffset = CGSize(width: 0, height: 0)
        destView.layer.shadowOpacity = 1.0
        destView.layer.shadowColor = UIColor.blackColor().CGColor
    }
    
    //MARK: - sidebar handle method
    func sideBarIsOpen() -> Bool {
        return scrollView.contentOffset.x == 0
    }
    
    func closeSideBar(animated: Bool) {
        scrollView.setContentOffset(CGPoint(x: CGRectGetWidth(leftViewController.view.frame), y: 0), animated: animated)
    }
    
    func openSideBar(animated: Bool) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    
    func toggleSideBar(animated: Bool) {
        if sideBarIsOpen() {
            closeSideBar(animated)
        } else {
            openSideBar(animated)
        }
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
