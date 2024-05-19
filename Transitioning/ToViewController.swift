//
//  ToViewController.swift
//  Transitioning
//
//  Created by Simone De Angelis on 07/05/24.
//

import UIKit


class ToViewController : UIViewController {
    
    weak var presentingVC : UIViewController?

    lazy var subView : UIView = {
        
        subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .purple
        subView.layer.cornerRadius = 5
        return subView
        
    }()
    
    lazy var littleImageView : UIImageView = {
        let littleImageView = UIImageView(image: UIImage(named: "vangogh"))
        littleImageView.translatesAutoresizingMaskIntoConstraints = false
        littleImageView.contentMode = .scaleAspectFit
        littleImageView.clipsToBounds = true
        return littleImageView
    }()
    
    lazy var titleLabel : UILabel = {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "A custom class for transitioning!"
        titleLabel.textColor = .orange
        titleLabel.font = .systemFont(ofSize: 20)
        return titleLabel
        
    }()
    
    lazy var smallRectangle : UIView = {
        smallRectangle = UIView()
        smallRectangle.translatesAutoresizingMaskIntoConstraints = false
        smallRectangle.backgroundColor = .green
        smallRectangle.layer.cornerRadius = 10
        return smallRectangle
    }()
    
    lazy var subSubView : UIView = {
        
        subSubView = UIView()
        subSubView.translatesAutoresizingMaskIntoConstraints = false
        subSubView.backgroundColor = .blue
        subSubView.layer.cornerRadius = 2
        return subSubView
        
    }()
    
    
    override func viewDidLoad() {
        
        
        self.view.addSubview(littleImageView)
       // self.view.addSubview(titleLabel)
        self.view.addSubview(smallRectangle)
        self.view.backgroundColor = .black
        self.view.addSubview(subSubView)
        
        littleImageView.isUserInteractionEnabled = true
        littleImageView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(popNav)))
        
        NSLayoutConstraint.activate([
            
            littleImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            littleImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            littleImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            littleImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            smallRectangle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            smallRectangle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            smallRectangle.widthAnchor.constraint(equalToConstant: 100),
            smallRectangle.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            subSubView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            subSubView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            subSubView.widthAnchor.constraint(equalToConstant: 100),
            subSubView.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            
        ])
        
        setupInteractiveDismiss()
    }
    
    func setupInteractiveDismiss(){
        
        let toVC = ToViewController()
        let interactiveClass = InteractiveTransitionClass(fromViewController: self, toViewController: toVC, isModal: false)
        interactiveClass.assignPanGesture(view: self.littleImageView)
        
        
    }
    

    
    
    @objc func popNav(){
        //MARK: -- code for navigation controller transition
//        guard let toVC = navigationController?.viewControllers[ (navigationController?.viewControllers.count ?? 0) - 2] as? FromViewController else {
//            print("smt went wrong ")
//            return
//        }
//        let transitionClass = StaticTransition(duration: 0.5, isModal: false , fromViewController: self)
//        
//        transitionClass.matchGeometryUIImageViews(fromImageView: self.littleImageView, toImageView: toVC.littleImageView)
//        transitionClass.matchSimpleUIViewGeometry(fromView: self.smallRectangle, toView: toVC.smallRectangle)
//        navigationController?.popViewController(animated: true)

        //MARK: -- code for modal transition
        
        let transitionClass = StaticTransition(duration: 0.5, isModal: true, fromViewController: self)
        let toVC = self.presentingVC as? FromViewController
        self.transitioningDelegate = transitionClass
        transitionClass.matchGeometryUIImageViews(fromImageView: self.littleImageView, toImageView: toVC!.littleImageView )
        transitionClass.matchSimpleUIViewGeometry(fromView: self.smallRectangle, toView: toVC!.smallRectangle)
     
        self.dismiss(animated: true)
        
        
    }
}
