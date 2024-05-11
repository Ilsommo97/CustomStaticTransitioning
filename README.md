A little section with code snippets. The current implementation supports both navigation using navigation controllers and modal presentation

## Navigation controller case : push or pop

When navigating using navigation controllers, initialize the transition class and match the geometries that you want to animate. After that, simply call push. An example: 

```swift
let toVC = ToViewController()
let transitionClass = StaticTransition(duration: 0.5, isModal: false, fromViewController: self)
transitionClass.matchGeometryUIImageViews(fromImageView: self.profilePic, toImageView: toVC.smallerProfilePic)
transitionClass.matchSimpleUIViewGeometry(fromView: self.bottomBar, toView: self.topBar)
navigationController?.pushViewController(toVC, animated: true)
```

When the class gets initialized, it’ll handle everythin for you, no more boiler plate code!

When popping  a view controller, you will need a reference to the view controller you’re returning to. You can either keep a weak reference to that view controller in the current view controller, or:

```swift
  guard let toVC = navigationController?.viewControllers[ (navigationController?.viewControllers.count ?? 0) - 2] as? FromViewController else {
      print("smt went wrong ")
      return
  }
  let transitionClass = StaticTransition(duration: 0.5, isModal: false , fromViewController: self)
  
  transitionClass.matchGeometryUIImageViews(fromImageView: self.smallerProfilePic, toImageView: toVC.profilePic)
  transitionClass.matchSimpleUIViewGeometry(fromView: self.topBar, toView: toVC.bottomBar)
  navigationController?.popViewController(animated: true)
```

## Modal presentation case: present or dismiss

When navigating using modal presentation, you will need to assign the transitioning delegate to the presented view controller. Moreover, you need to keep a weak reference of the presenting view controller in the presenting view controller ( this is needed when dismissing the presented view controller)

```swift
let toVC = ToViewController()
toVC.presentingVC = self
let transitionClass = StaticTransition(duration: 0.5, isModal: true, fromViewController: self)
toVC.modalPresentationStyle = .fullScreen
toVC.transitioningDelegate = transitionClass
transitionClass.matchGeometryUIImageViews(fromImageView: self.littleImageView, toImageView: toVC.littleImageView)
transitionClass.matchSimpleUIViewGeometry(fromView: smallRectangle, toView: toVC.smallRectangle)
self.present(toVC, animated: true)
```

When dismissing, remember to assign the transitioning delegate:
