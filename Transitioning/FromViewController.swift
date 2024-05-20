//
//  ViewController.swift
//  Transitioning
//
//  Created by Simone De Angelis on 07/05/24.
//

import UIKit

class FromViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
    lazy var bottomBar : UIView = {
       
        
        bottomBar = UIView()
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.backgroundColor = UIColor(.blue).withAlphaComponent(0.5)
        return bottomBar
    }()
    
    
    
    lazy var littleImageView : UIImageView = {
        let littleImageView = UIImageView(image: UIImage(named: "vangogh"))
        littleImageView.translatesAutoresizingMaskIntoConstraints = false
        littleImageView.contentMode = .scaleAspectFill
        littleImageView.clipsToBounds = true
        littleImageView.layer.cornerRadius = 10
        littleImageView.isUserInteractionEnabled = true
        return littleImageView
    }()
    
    lazy var titleLabel : UILabel = {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "A custom class for transitioning!"
        titleLabel.textColor = .orange
        titleLabel.font = .systemFont(ofSize: 25)
        return titleLabel
        
    }()
    
    lazy var smallRectangle : UIView = {
        smallRectangle = UIView()
        smallRectangle.translatesAutoresizingMaskIntoConstraints = false
        smallRectangle.backgroundColor = .green
        smallRectangle.layer.cornerRadius = 10
        return smallRectangle
    }()

    
    lazy var complexView : UIView = {
        
        complexView = UIView()
        complexView.translatesAutoresizingMaskIntoConstraints = false
        complexView.backgroundColor = .orange
        complexView.layer.cornerRadius = 20
        return complexView
        
    }()
    
    
    lazy var subView : UIView = {
        
        subView = UIView()
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.backgroundColor = .purple
        subView.layer.cornerRadius = 5
        return subView
        
    }()
    
    lazy var subSubView : UIView = {
        
        subSubView = UIView()
        subSubView.translatesAutoresizingMaskIntoConstraints = false
        subSubView.backgroundColor = .blue
        subSubView.layer.cornerRadius = 2
        return subSubView
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        self.view.addSubview(bottomBar)
        self.bottomBar.addSubview(littleImageView)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(smallRectangle)
        self.view.addSubview(complexView)
        
        self.complexView.addSubview(subView)
        self.subView.addSubview(subSubView)
        littleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTap)))
        
        NSLayoutConstraint.activate([
            
            bottomBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomBar.heightAnchor.constraint(equalToConstant: 350),
            bottomBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        
            littleImageView.leadingAnchor.constraint(equalTo: self.bottomBar.leadingAnchor, constant: 20),
            littleImageView.bottomAnchor.constraint(equalTo:  self.bottomBar.bottomAnchor, constant: -20),
            littleImageView.widthAnchor.constraint(equalToConstant: 200),
            littleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            smallRectangle.widthAnchor.constraint(equalToConstant: 150),
            smallRectangle.heightAnchor.constraint(equalToConstant: 100),
            smallRectangle.leadingAnchor.constraint(equalTo: self.littleImageView.trailingAnchor, constant: 20),
            smallRectangle.centerYAnchor.constraint(equalTo: self.littleImageView.centerYAnchor),
            
            complexView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            complexView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            complexView.widthAnchor.constraint(equalToConstant: 300),
            complexView.heightAnchor.constraint(equalToConstant: 200),
            
            
            subView.leadingAnchor.constraint(equalTo: self.complexView.leadingAnchor, constant: 10),
            subView.centerYAnchor.constraint(equalTo: self.complexView.centerYAnchor),
            subView.widthAnchor.constraint(equalToConstant: 100),
            subView.heightAnchor.constraint(equalToConstant: 100),
            
            
            subSubView.leadingAnchor.constraint(equalTo: self.subView.leadingAnchor, constant: 10),
            subSubView.centerYAnchor.constraint(equalTo: self.subView.centerYAnchor),
            subSubView.widthAnchor.constraint(equalToConstant: 50),
            subSubView.heightAnchor.constraint(equalToConstant: 50)

        ])
        
    }
    
    @objc func imageTap(){
        //MARK: -- Modal transition case
//        let toVC = ToViewController()
//        toVC.presentingVC = self
//        let transitionClass = StaticTransition(duration: 0.5, isModal: true, fromViewController: self)
//        toVC.modalPresentationStyle = .fullScreen
//        toVC.transitioningDelegate = transitionClass
//        transitionClass.matchGeometryUIImageViews(fromImageView: self.littleImageView, toImageView: toVC.littleImageView)
//        
//        transitionClass.matchSimpleUIViewGeometry(fromView: smallRectangle, toView: toVC.smallRectangle)
//      
//        transitionClass.addNonMatchingView(customView: self.titleLabel, animatablePropertiesFrom: AnimatableProperties(), animatablePropertiesTo: AnimatableProperties(transform: CGAffineTransform(scaleX: 0.01, y: 0.01)))
//                                           
//        transitionClass.matchSimpleUIViewGeometry(fromView: subSubView, toView: toVC.subSubView)
//        self.present(toVC, animated: true)
        
        
        //MARK: -- Navigation controller transition case
        let toVC = ToViewController()
        toVC.presentingVC = self
        let transitionClass = StaticTransition(duration: 10.5, isModal: false, fromViewController: self, springDamping: 10)
        //MARK: -- Matching views
        transitionClass.matchGeometryUIImageViews(fromImageView: self.littleImageView, toImageView: toVC.littleImageView)
        transitionClass.matchSimpleUIViewGeometry(fromView: self.smallRectangle, toView: toVC.smallRectangle)
        transitionClass.matchSimpleUIViewGeometry(fromView: self.subSubView, toView: toVC.subSubView)
        
        //MARK: -- Non matching views
        transitionClass.addNonMatchingView(view: titleLabel,
                                           animatablePropertiesFrom: AnimatableProperties(),
                                           animatablePropertiesTo: AnimatableProperties(transform: CGAffineTransform(translationX: 400, y: 0)),
                                           isToVC: false
        )
        
        
        
        navigationController?.pushViewController(toVC, animated: true)
        
    }


}

