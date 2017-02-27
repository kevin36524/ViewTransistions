//
//  AppDelegate.swift
//  ViewTransitions
//
//  Created by Kevin Balvantkumar Patel on 2/23/17.
//  Copyright © 2017 LZChat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let navigationViewController = window?.rootViewController as? UINavigationController {
            navigationViewController.delegate = self
        }
        return true
    }

}

extension AppDelegate : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ListToDetailAnimataionController()
    }
}

class ListToDetailAnimataionController : NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval = 0.4
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get from and to VC
        // get container
        // get toView
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let toView = transitionContext.view(forKey: .to) else {return}
        
        let container = transitionContext.containerView
        
        
        // Add toView to container
        container.addSubview(toView)
        // set its size
        toView.frame = transitionContext.finalFrame(for: toVC)
        // layoutIfNeeded()
        toView.layoutIfNeeded()
        // alpha 0
        toView.alpha = 0
        // transition to alpha 1
        UIView.animate(withDuration: duration, animations: { 
            toView.alpha = 1
        }) { (isCompleted) in
            // tell transitionContext that the transition was done.
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}










