//
//  InteractiveTransitionClass.swift
//  Transitioning
//
//  Created by Simone De Angelis on 14/05/24.
//

import UIKit



class InteractiveTransitionClass : NSObject, UIViewControllerInteractiveTransitioning, UIViewControllerAnimatedTransitioning{
    

    
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        // This one is useless
        return TimeInterval(floatLiteral: 0.1)
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        fatalError("animateTransition protocol stub called, pls check the workflow of the interactive transition class")
    }
    
    func startInteractiveTransition(_ transitionContext: any UIViewControllerContextTransitioning) {
        print("we reached the interactive transition part")
        return
    }
    
}

extension InteractiveTransitionClass {
    
    func assignPanGesture(view : UIView) {
        
        view.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        view.addGestureRecognizer(panGesture)
        
    }
    
    
    
    @objc func didPan(_ gesture : UIPanGestureRecognizer) {
        
        
        
    }
}

extension InteractiveTransitionClass : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        print("we re returning in the interactive transition delegate for the navigation controller delegate")
        return self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        print("we re returning in the static transition delegate")
        return self
    }
    
}
