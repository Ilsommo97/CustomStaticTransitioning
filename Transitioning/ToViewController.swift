//
//  ToViewController.swift
//  Transitioning
//
//  Created by Simone De Angelis on 07/05/24.
//

import UIKit


class ToViewController : UIViewController {
    
    weak var presentingVC : UIViewController?

    
    lazy var littleImageView : UIImageView = {
        let littleImageView = UIImageView(image: UIImage(named: "vangogh"))
        littleImageView.translatesAutoresizingMaskIntoConstraints = false
        littleImageView.contentMode = .scaleAspectFit
        littleImageView.clipsToBounds = true
        littleImageView.layer.cornerRadius = 10
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
        smallRectangle.backgroundColor = .yellow
        smallRectangle.layer.cornerRadius = 10
        return smallRectangle
    }()
    
    
    
    override func viewDidLoad() {
        
        
        self.view.addSubview(littleImageView)
       // self.view.addSubview(titleLabel)
        self.view.addSubview(smallRectangle)
        self.view.backgroundColor = .black
        
        littleImageView.isUserInteractionEnabled = true
        littleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(popNav)))
        NSLayoutConstraint.activate([
            
            littleImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            littleImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            littleImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            littleImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            smallRectangle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            smallRectangle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            smallRectangle.widthAnchor.constraint(equalToConstant: 50),
            smallRectangle.heightAnchor.constraint(equalToConstant: 25)
        ])
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
        self.dismiss(animated: true)
        
        
    }
}