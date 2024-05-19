//
//  InteractiveTransitionClass.swift
//  Transitioning
//
//  Created by Simone De Angelis on 14/05/24.
//

import UIKit



class InteractiveTransitionClass : NSObject, UIViewControllerInteractiveTransitioning{
    

    weak var fromViewController : UIViewController?
    
    weak var toViewController : UIViewController?
    
    private weak var transitionContext : UIViewControllerContextTransitioning? = nil
    
    var isModal : Bool
    
   
    init(fromViewController: UIViewController? = nil, toViewController: UIViewController? = nil, isModal: Bool) {
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        self.isModal = isModal
        super .init()
        conformToDelegate()
    }
    
    private func conformToDelegate(){
        
        if let navController = fromViewController?.navigationController {
            navController.delegate = self
        }
        
        if isModal {
            fromViewController?.transitioningDelegate = self
            toViewController?.transitioningDelegate = self
        }
        
        
    }
    
    //MARK: -- This is where we get the transition context. Once we reach this function, we have access to the container View
    func startInteractiveTransition(_ transitionContext: any UIViewControllerContextTransitioning) {
        print("we reached the interactive transition part")
        return
    }
    
}






extension InteractiveTransitionClass {
    
    func assignPanGesture(view : UIView) {
        print("we assigned")
        view.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        view.addGestureRecognizer(panGesture)
        
    }
    
    
    
    @objc func didPan(_ gesture : UIPanGestureRecognizer) {
        
        
        print("we reach the pan ")
        switch gesture.state {
    
        case .began:
            print(" push or pop the navigation here, or present/dismiss")
            break
        
        case .changed:
            
            break
        
        case .ended:
            break
            
        case .cancelled:
            break
            
        case .failed:
            break
            
        default:
            break
            
            
        }
        
        
    }
}


// MARK: -- Boiler plate code: The interactive transitioning class needs to conform to the same delegate and stub protocol for the static transition stuff.

extension InteractiveTransitionClass : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        // This one is useless
        return TimeInterval(floatLiteral: 0.1)
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        fatalError("animateTransition protocol stub called, pls check the workflow of the interactive transition class")
    }
}

extension InteractiveTransitionClass : UINavigationControllerDelegate {
    
    // MARK: -- Navigation controller delegates
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        print("we re returning in the interactive transition delegate for the navigation controller delegate")
        return self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        print("we re returning in the static transition delegate")
        return self
    }
    
}

extension InteractiveTransitionClass : UIViewControllerTransitioningDelegate {
    
    //MARK: -- Modal presentation delegates
    
    // Static Transition delegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return self
    }
    // Static Transition delegate
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return self
    }
    
    func interactionControllerForPresentation(using animator: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        return self
    }
    
    func interactionControllerForDismissal(using animator: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        return self
    }
}
