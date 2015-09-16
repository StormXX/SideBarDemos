//
//  UberSideBarViewController.swift
//  UberSideBar
//
//  Created by DangGu on 15/9/16.
//  Copyright © 2015年 Donggu. All rights reserved.
//

import UIKit

class UberSideBarViewController: UIViewController {
    
    var originCenter: CGPoint = CGPoint(x: 0, y: 0)
    var targetCenter: CGPoint = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        if sideBarIsOpen() {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - help method
    func setupView() {
        //set view frame
        let frame = view.frame
        let width = CGRectGetWidth(frame) - UIScreen.mainScreen().bounds.width * 0.3
        view.frame = CGRectMake(-width, 0, width, CGRectGetHeight(frame))
        originCenter = view.center
        targetCenter = CGPoint(x: CGRectGetWidth(view.frame)/2, y: view.center.y)
        
        //set backgroundColor
        view.backgroundColor = UIColor.uberLightDarkColor()
    }
    
    func sideBarIsOpen() -> Bool {
        return CGRectGetMaxX(view.frame) > 0
    }
    
    //MARK: - gesture method
    func addGesture() {
        addScreenEdgePanGesture()
        addPanGesture()
    }
    
    func addScreenEdgePanGesture() {
        let edgePanGesture: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "screenEdgePanGestureHandle:")
        edgePanGesture.edges = UIRectEdge.Left
        edgePanGesture.delegate = self
        self.parentViewController?.view.addGestureRecognizer(edgePanGesture)
    }
    
    func addPanGesture() {
        let panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panGestureHandle:")
        panGesture.delegate = self
        self.parentViewController?.view.addGestureRecognizer(panGesture)
    }
    
    //MARK: - gesture selector
    func screenEdgePanGestureHandle(recognizer: UIScreenEdgePanGestureRecognizer) {
        let x = recognizer.translationInView(recognizer.view).x
        
        if recognizer.state == UIGestureRecognizerState.Ended {
            if x > CGRectGetWidth(view.frame)/3 {
                showUberSideBar()
            } else {
                hideUberSideBar()
            }
            return
        }
        
        if x > CGRectGetWidth(view.frame) {
            return;
        }
        
        view.center.x = originCenter.x + x
    }
    
    func panGestureHandle(recognizer: UIPanGestureRecognizer) {
        let x = recognizer.translationInView(recognizer.view).x
        if x < 0 && sideBarIsOpen(){
            if recognizer.state == UIGestureRecognizerState.Ended {
                if -x < CGRectGetWidth(view.frame)/3 {
                    showUberSideBar()
                } else {
                    hideUberSideBar()
                }
                return
            }
            
            if -x > CGRectGetWidth(view.frame) {
                return
            }
            
            view.center.x = targetCenter.x + x
        }
    }
    
    //MARK: - handle method
    func showUberSideBar() {
        let center = CGPoint(x: CGRectGetWidth(view.frame)/2, y: view.center.y)
        animationUberSideBar(center)
    }
    
    func hideUberSideBar() {
        let center = CGPoint(x: -CGRectGetWidth(view.frame)/2, y: view.center.y)
        animationUberSideBar(center)
    }
    
    func animationUberSideBar(center: CGPoint) {
        UIView.animateWithDuration(0.33, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.view.center = center
            }) { (finished) -> Void in
                if center.x < 0 {
                    UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
                } else {
                    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Slide)
                }
        }
    }

}

extension UberSideBarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if gestureRecognizer.isMemberOfClass(UIPanGestureRecognizer.self) {
            if sideBarIsOpen() {
                return true
            } else {
                return false
            }
        } else if gestureRecognizer.isMemberOfClass(UIScreenEdgePanGestureRecognizer.self) {
            if sideBarIsOpen() {
                return false
            } else {
                return true
            }
        }

        return false
    }
}




