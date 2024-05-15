//
//  TransitionClass.swift
//  Transitioning
//
//  Created by Simone De Angelis on 06/05/24.
//

import Foundation
import UIKit


public func calculateZoomInImageFrame(image: UIImage, forView view: UIView) -> CGRect {
        
        let viewRatio = view.frame.size.width / view.frame.size.height
        let imageRatio = image.size.width / image.size.height
        let touchesSides = (imageRatio > viewRatio)
        
        if touchesSides {
            let height = view.frame.width / imageRatio
            let yPoint = view.frame.minY + (view.frame.height - height) / 2
            return CGRect(x: 0, y: yPoint, width: view.frame.width, height: height)
        } else {
            let width = view.frame.height * imageRatio
            let xPoint = view.frame.minX + (view.frame.width - width) / 2
            return CGRect(x: xPoint, y: 0, width: width, height: view.frame.height)
        }
}



struct FromAndToView {
    
    var fromView : UIView
    
    var toView : UIView
    
}

struct SnapShotAndProperties {
    
    
    var snapshotView : UIView
    
    var propertiesFrom : AnimatableProperties
    
    var propertiesTo : AnimatableProperties
}

class StaticTransition : NSObject,
                         UIViewControllerAnimatedTransitioning, // The static transition itself : the animation core
                         UINavigationControllerDelegate,  // delegate that returns the static transition for nav style
                         UIViewControllerTransitioningDelegate // delegate that return the static transition for modal style
{

    let duration : Double
    
    weak var fromViewController : UIViewController?
    
    public var animator : UIViewPropertyAnimator?
    
    var isModalTransition : Bool?
    
    var dictionarySimpleUIView : [UIView : FromAndToView] = [:] // A note on this dicionary: the key is made of the animatable uiview. This si the view that is getting created and added to the container view. The struct from and to view instead holds the from and to view passed inside the function that the user calls
    
    var dictionaryImageView : [UIImageView : FromAndToView]  = [:]
    
    var dictionaryCustomView : [UIView : SnapShotAndProperties ] = [:]
    
    var dictionaryScreenUpdate : [UIView : Bool] = [:]
    
    
    init(duration : Double, isModal : Bool, fromViewController : UIViewController, springDamping : CGFloat? = nil ){
        
        self.duration = duration
        self.fromViewController = fromViewController
        self.isModalTransition = isModal
        if springDamping != nil {
            self.animator = UIViewPropertyAnimator(duration: duration, dampingRatio: springDamping!)

        }else {
            self.animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut)
        }
        super .init()
        conformToDelegate()
        
    }
    
    private func conformToDelegate(){
        //MARK: -- Call this function to conform the delegate to the uinavigationcontroller delegate
        
        if let navController = self.fromViewController?.navigationController {
            if !isModalTransition! {
                navController.delegate = self
            }
        }
    }
    
    

    //MARK: -- Delegate function for the navigation controller. Here we specify the transition that we return, i.e this class, that also adhere to the UIViewControllerAnimatedTransitioning protocol functions transitionDuration and  animateTransition
    internal func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {

        return self
    }
    
    //MARK: -- Delegate function for the modal transition delegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        print("presented call for modal presentation : static")
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        print("dismissed presentation called")
        return self
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
    }
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        print("presented call for modal presentation : dynaimc")
        return nil
    }
    
    //Protocol function for the UIViewControllerAnimatedTransitioning delegate
    internal func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        return TimeInterval(floatLiteral: duration)
    }
    
    //Protocol function for the UIViewControllerAnimatedTransitioning delegate
    internal func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        startTransition(with: transitionContext)
    }
    
    //MARK: -- Custom function that let the user add animations to view to this transition class.
    
    // Simple views functions
    public func matchSimpleUIViewGeometry(fromView : UIView, toView : UIView){
        //MARK: -- Use this function to morph simple uiviews. This function does not support views that have subviews in it
        
        if fromView is UIImageView || fromView is UILabel  {
            print("Please use the dedicate match functions for image views or uilabels")
            return
        }
        if toView is UIImageView || toView is UILabel  {
            print("Please use the dedicate match functions for image views or uilabels")
            return
        }
        if !fromView.subviews.isEmpty || !toView.subviews.isEmpty {
            print(" Warning:Visual error may arise, since the views you are adding with the matchSimpleViewGeometry function have subviews ")
        }
        
        let animatableView = UIView()
        
        animatableView.frame = fromView.frameInGlobalCoordinateSystem() ?? .zero
        animatableView.backgroundColor = fromView.backgroundColor
        animatableView.alpha = fromView.alpha
        animatableView.clipsToBounds = fromView.clipsToBounds
        animatableView.layer.cornerRadius = fromView.layer.cornerRadius
        
   //     let animatablePropToView = extractAnimatableProperties(view: toView)
        
        let customStruct = FromAndToView(fromView: fromView, toView: toView)
        
        dictionarySimpleUIView[animatableView] = customStruct
        
    }
    
    
    // uiimage views functions ... @@@ work in progress @@@
    public func matchGeometryUIImageViews(fromImageView : UIImageView, toImageView: UIImageView){
        
        let animatableImageView = UIImageView()
        animatableImageView.image = fromImageView.image
        animatableImageView.contentMode = .scaleAspectFill
        animatableImageView.layer.cornerRadius = fromImageView.layer.cornerRadius
        animatableImageView.clipsToBounds = fromImageView.clipsToBounds
        animatableImageView.alpha = fromImageView.alpha
        // Frame computation in the from
        if fromImageView.contentMode == .scaleAspectFit {
            animatableImageView.frame = calculateZoomInImageFrame(image: animatableImageView.image!, forView: fromImageView)
            print(" the from image view is in scale aspect fit mode, the frame computed is \(  animatableImageView.frame)")

        } else {
            animatableImageView.frame = fromImageView.frameInGlobalCoordinateSystem() ?? .zero
            print(" the from image view is in scale aspect fill mode, the frame computed is \(  animatableImageView.frame)")

        }
        
        let customStruct = FromAndToView(fromView: fromImageView, toView: toImageView)
        
        dictionaryImageView[animatableImageView] = customStruct
    }
    

    private func addViews(containerView : UIView){
        
        dictionarySimpleUIView.keys.forEach({
            view in
            dictionarySimpleUIView[view]?.fromView.isHidden = true
            dictionarySimpleUIView[view]?.toView.isHidden = true

            containerView.addSubview(view)
        })
        
        dictionaryImageView.keys.forEach({
            view in
            dictionaryImageView[view]?.fromView.isHidden = true
            dictionaryImageView[view]?.toView.isHidden = true

            containerView.addSubview(view)
        })
        
        dictionaryCustomView.keys.forEach({
            view in
            guard let snapShotView = view.snapshotView(afterScreenUpdates:  dictionaryScreenUpdate[view] ?? false) else {return}
            let propertiesFrom = dictionaryCustomView[view]?.propertiesFrom // the to properties
            let propertiesTo = dictionaryCustomView[view]?.propertiesTo
            snapShotView.applyAnimatableProperties(view.extractAnimatableProperties())
            snapShotView.applyAnimatableProperties(propertiesFrom!)
            dictionaryCustomView[view] = SnapShotAndProperties(snapshotView: snapShotView,
                                                               propertiesFrom: propertiesFrom!,
                                                               propertiesTo: propertiesTo!)
            view.isHidden = true
            containerView.addSubview(snapShotView)
        })
        
        
    }
    private func animateAddedViews(){
        
        dictionarySimpleUIView.keys.forEach({
            view in
            
            view.frame =                dictionarySimpleUIView[view]?.toView.frame ?? .zero
            view.backgroundColor =      dictionarySimpleUIView[view]?.toView.backgroundColor
            view.alpha =                dictionarySimpleUIView[view]?.toView.alpha ?? 1
            view.clipsToBounds =        dictionarySimpleUIView[view]?.toView.clipsToBounds ?? false
            view.layer.cornerRadius =   dictionarySimpleUIView[view]?.toView.layer.cornerRadius ?? 0
            
        })
        
        dictionaryImageView.keys.forEach({
            view in
        
            view.alpha =                dictionaryImageView[view]?.toView.alpha ?? 1
            view.clipsToBounds =        dictionaryImageView[view]?.toView.clipsToBounds ?? false
            view.layer.cornerRadius =   dictionaryImageView[view]?.toView.layer.cornerRadius ?? 0
            print("view radius \(view.layer.cornerRadius)")
            view.backgroundColor =      dictionaryImageView[view]?.toView.backgroundColor

            if dictionaryImageView[view]?.toView.contentMode == .scaleAspectFill {
                print(" The to frame is in scale aspect fill")
                view.frame = dictionaryImageView[view]?.toView.frame ?? .zero
            }
            else if dictionaryImageView[view]?.toView.contentMode == .scaleAspectFit {
                var constantView : UIView? = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                view.frame = calculateZoomInImageFrame(image: view.image ?? UIImage(),
                                                       forView: (dictionaryImageView[view]?.toView ?? constantView)! )
                constantView = nil
            }
            
        })
 
        dictionaryCustomView.keys.forEach({
            view in
            dictionaryCustomView[view]!.snapshotView.applyAnimatableProperties(  dictionaryCustomView[view]!.propertiesTo)
        })
    }
    
    private func completionAddedViews(){
        dictionarySimpleUIView.keys.forEach({
            view in
            dictionarySimpleUIView[view]?.fromView.isHidden = false
            dictionarySimpleUIView[view]?.toView.isHidden = false
            view.removeFromSuperview()
            
            
        })
        
        dictionaryImageView.keys.forEach({
            view in
            dictionaryImageView[view]?.fromView.isHidden = false
            dictionaryImageView[view]?.toView.isHidden = false
            view.removeFromSuperview()
            
        })
        
        dictionaryCustomView.keys.forEach({
            view in
            
            view.isHidden = false
            dictionaryCustomView[view]?.snapshotView.removeFromSuperview()
        })
        
        dictionarySimpleUIView = [ : ]
        dictionaryImageView = [ : ]
        dictionaryCustomView = [ : ]
    }
    

    //MARK: -- The following functions are called inside the protocol function implemented... Maybe the distinction between a pop or push doesnt make that much sense for a implementation like this... Revisiting this later
    private func startTransition(with transitionContext : UIViewControllerContextTransitioning){
        
       
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
//     
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        toView.alpha = 0
        containerView.layoutIfNeeded()
        addViews(containerView: containerView)
      
        self.animator?.addAnimations({
            self.animateAddedViews()
            toView.alpha = 1
            fromView.alpha = 0
        })
        
        self.animator?.addCompletion({
            completed in
            self.completionAddedViews()
            fromView.alpha = 1
            transitionContext.completeTransition(true)

        })
        
        self.animator?.startAnimation()
        
    }
            
}


extension StaticTransition {
    
    //MARK: -- Extension implementing the addCustomViewToTransition
    // The public method allows the user to add a custom view to the container view, specifying the animation it should have.
    
    public func addNonMatchingView(view : UIView,  animatablePropertiesFrom : AnimatableProperties, animatablePropertiesTo : AnimatableProperties, isToVC : Bool){
        
        
        // MARK: -- the custom view added in this method needs to be a view already present in the from view controller or in the to view controller. The animatable properties will be the properties interpolated during the transition.
        
        
        dictionaryCustomView[view] = SnapShotAndProperties(snapshotView: UIView(), propertiesFrom: animatablePropertiesFrom, propertiesTo: animatablePropertiesTo)
        
        dictionaryScreenUpdate[view] = isToVC
        
        
        
    }
    
    
}
