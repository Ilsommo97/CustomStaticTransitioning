//
//  ViewController.swift
//  Transitioning
//
//  Created by Simone De Angelis on 07/05/24.
//

import UIKit

class FromViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
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
        titleLabel.font = .systemFont(ofSize: 20)
        return titleLabel
        
    }()
    
    lazy var smallRectangle : UIView = {
        smallRectangle = UIView()
        smallRectangle.translatesAutoresizingMaskIntoConstraints = false
        smallRectangle.backgroundColor = .blue
        smallRectangle.layer.cornerRadius = 10
        return smallRectangle
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        self.view.addSubview(littleImageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(smallRectangle)
        
        littleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTap)))
        
        NSLayoutConstraint.activate([
        
            littleImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:20),
            littleImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            littleImageView.widthAnchor.constraint(equalToConstant: 200),
            littleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            smallRectangle.widthAnchor.constraint(equalToConstant: 150),
            smallRectangle.heightAnchor.constraint(equalToConstant: 100),
            smallRectangle.leadingAnchor.constraint(equalTo: self.littleImageView.trailingAnchor, constant: 20),
            smallRectangle.centerYAnchor.constraint(equalTo: self.littleImageView.centerYAnchor)

            
        ])
        
    }
    
    @objc func imageTap(){
        //MARK: -- Modal transition case
        let toVC = ToViewController()
        toVC.presentingVC = self
        let transitionClass = StaticTransition(duration: 0.5, isModal: true, fromViewController: self)
        toVC.modalPresentationStyle = .fullScreen
        toVC.transitioningDelegate = transitionClass
        transitionClass.matchGeometryUIImageViews(fromImageView: self.littleImageView, toImageView: toVC.littleImageView)
        
        transitionClass.matchSimpleUIViewGeometry(fromView: smallRectangle, toView: toVC.smallRectangle)
        
        transitionClass.addNonMatchingView(customView: self.titleLabel,
                                           animatableProperties: AnimatableProperties(
                                            transform: CGAffineTransform(translationX: 200, y: 0),
                                            alpha: 0.6
                                           )
                                           
        )
        self.present(toVC, animated: true)
        
        //MARK: -- Navigation controller transition case
//        let toVC = ToViewController()
//        let transitionClass = StaticTransition(duration: 0.5, isModal: false, fromViewController: self)
//        transitionClass.matchGeometryUIImageViews(fromImageView: self.profilePic, toImageView: toVC.smallerProfilePic)
//        transitionClass.matchSimpleUIViewGeometry(fromView: self.bottomBar, toView: self.topBar)
//        navigationController?.pushViewController(toVC, animated: true)
    }


}

