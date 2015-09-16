//
//  ViewController.swift
//  SwiftSideSlide
//
//  Created by DangGu on 15/9/13.
//  Copyright © 2015年 Donggu. All rights reserved.
//

import UIKit

struct Common {
    static let screenWidth = UIScreen.mainScreen().applicationFrame.maxX
    static let screenHeight = UIScreen.mainScreen().applicationFrame.maxY
}

class ViewController: UIViewController {

    var homeViewController: HomeViewController!
    var distance: CGFloat = 0
    
    let FullDistance: CGFloat = 0.78
    let Proportion:   CGFloat = 0.77
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        view.addSubview(homeViewController.view)
        
        homeViewController.panGesture.addTarget(self, action: "pan:")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - response method
    
    func pan(recognizer: UIPanGestureRecognizer){
        let x = recognizer.translationInView(view).x
        let trueDistance = distance + x
        
        if recognizer.state == UIGestureRecognizerState.Ended {
            if trueDistance > Common.screenWidth * (Proportion/3) {
                showLeft()
            } else if trueDistance < Common.screenWidth * -(Proportion/3) {
            
            } else {
                showHome()
            }
            return
        }
        
        var proportion: CGFloat = 1
        proportion *= trueDistance / Common.screenWidth
        proportion *= Proportion - 1
        proportion /= 0.6
        proportion += 1
        if proportion < Proportion {
            return
        }
        
        recognizer.view!.center = CGPoint(x: view.center.x + trueDistance, y: view.center.y)
        recognizer.view!.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
        
    }
    
    //MARK: - private method
    func showLeft() {
        distance = view.center.x * (FullDistance + Proportion/2)
        doTheAnimation(Proportion)
    }
    
    func showHome() {
        distance = 0
        doTheAnimation(1)
    }
    
    func doTheAnimation(proportion: CGFloat) {
        UIView.animateWithDuration(0.33, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.homeViewController.view.center = CGPoint(x: self.view.center.x + self.distance, y: self.view.center.y)
            self.homeViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion)
            }, completion: nil)
    }

}

