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

protocol ListToDetailAnimatable {
    var animatableCells: [UIView] {get}
    var morphViews: [UIView] {get}
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
            let fromAnimatableVC = fromVC as? ListToDetailAnimatable,
            let toAnimatableVC = toVC as? ListToDetailAnimatable,
            let toView = transitionContext.view(forKey: .to) else {return}
        
        let container = transitionContext.containerView
        // Add toView to container
        container.addSubview(toView)
        // set its size
        toView.frame = transitionContext.finalFrame(for: toVC)
        // layoutIfNeeded()
        toView.layoutIfNeeded()
        
        // Add a canvas
        let canvas = UIView(frame: container.frame)
        canvas.backgroundColor = toView.backgroundColor
        container.addSubview(canvas)
        
        // Add snapshots of incoming and outgoing snapshots
        let outgoingSnapShots = canvas.snapShotViews(views: fromAnimatableVC.animatableCells, afterUpdates: false)
        let incomingSnapShots = canvas.snapShotViews(views: toAnimatableVC.animatableCells, afterUpdates: true)
        
        // PerformAnimations
        let scaleTransform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        for view in incomingSnapShots {
            view.transform = scaleTransform
            view.alpha = 0
        }
    
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeLinear, animations: { 
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
                //shrink outgoingSnapshots
                for view in outgoingSnapShots {
                    view.transform = scaleTransform
                    view.alpha = 0
                }
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
                //grow incomingSnapshots
                for view in incomingSnapShots {
                    view.transform = CGAffineTransform.identity
                    view.alpha = 1
                }
            })
            
        }) { _ in
            canvas.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        animateMorphViews(views: Array(zip(fromAnimatableVC.morphViews, toAnimatableVC.morphViews)), canvas: canvas)
    }
    
    func animateMorphView(fromView: UIView, toView: UIView, canvas: UIView) {
        let fromView = canvas.snapShotView(view: fromView, afterUpdates: false)
        let toView = canvas.snapShotView(view: toView, afterUpdates: true)
        
        let targetCenter = toView.center
        toView.alpha = 0
        toView.transform = fromView.scaleTranformfromToView(toView)
        toView.center = fromView.center
        
        UIView.animate(withDuration: duration) { 
            fromView.alpha = 0
            fromView.transform = toView.transform.inverted()
            fromView.center = targetCenter
            
            toView.alpha = 1
            toView.transform = CGAffineTransform.identity
            toView.center = targetCenter
        }
    }
    
    func animateMorphViews(views: [(fromView:UIView, toView:UIView)], canvas: UIView) {
        views.forEach{ animateMorphView(fromView: $0.fromView, toView: $0.toView, canvas: canvas)}
    }
}

extension UIView {
    func snapShotView(view:UIView, afterUpdates: Bool) -> UIView {
        let snapShot = view.snapshotView(afterScreenUpdates: afterUpdates)
        self.addSubview(snapShot!)
        snapShot?.frame = convert(view.bounds, from: view)
        return snapShot!
    }
    
    func snapShotViews(views:[UIView], afterUpdates: Bool) -> [UIView] {
        return views.map{
            return snapShotView(view: $0, afterUpdates: afterUpdates)
        }
    }
    
    func scaleTranformfromToView(_ toView: UIView) -> CGAffineTransform {
        return CGAffineTransform(scaleX: bounds.width/toView.bounds.width, y: bounds.height/toView.bounds.height)
    }
}




class FadeAnimataionController : NSObject, UIViewControllerAnimatedTransitioning {
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










