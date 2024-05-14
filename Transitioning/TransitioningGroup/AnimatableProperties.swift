//
//  AnimatableProperties.swift
//  Transitioning
//
//  Created by Simone De Angelis on 14/05/24.
//

import UIKit


struct AnimatableProperties {
    var frame: CGRect?
    var bounds: CGRect?
    var center: CGPoint?
    var transform: CGAffineTransform?
    var alpha: CGFloat?
    var backgroundColor: UIColor?
    var tintColor: UIColor?
    var cornerRadius: CGFloat?
    var borderWidth: CGFloat?
    var borderColor: CGColor?
    var shadowColor: CGColor?
    var shadowOpacity: Float?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowPath: CGPath?
    var contentMode: UIView.ContentMode?
}

extension UIView {
    func applyAnimatableProperties(_ properties: AnimatableProperties) {
        if let frame = properties.frame {
            self.frame = frame
        }
        if let bounds = properties.bounds {
            self.bounds = bounds
        }
        if let center = properties.center {
            self.center = center
        }
        if let transform = properties.transform {
            self.transform = transform
        }
        if let alpha = properties.alpha {
            self.alpha = alpha
        }
        if let backgroundColor = properties.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let tintColor = properties.tintColor {
            self.tintColor = tintColor
        }
        if let cornerRadius = properties.cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        if let borderWidth = properties.borderWidth {
            self.layer.borderWidth = borderWidth
        }
        if let borderColor = properties.borderColor {
            self.layer.borderColor = borderColor
        }
        if let shadowColor = properties.shadowColor {
            self.layer.shadowColor = shadowColor
        }
        if let shadowOpacity = properties.shadowOpacity {
            self.layer.shadowOpacity = shadowOpacity
        }
        if let shadowOffset = properties.shadowOffset {
            self.layer.shadowOffset = shadowOffset
        }
        if let shadowRadius = properties.shadowRadius {
            self.layer.shadowRadius = shadowRadius
        }
        if let shadowPath = properties.shadowPath {
            self.layer.shadowPath = shadowPath
        }
        if let contentMode = properties.contentMode {
            self.contentMode = contentMode
        }
    }
    
    
    func extractAnimatableProperties() -> AnimatableProperties {
        return AnimatableProperties(
            frame: self.frame,
            bounds: self.bounds,
            center: self.center,
            transform: self.transform,
            alpha: self.alpha,
            backgroundColor: self.backgroundColor,
            tintColor: self.tintColor,
            cornerRadius: self.layer.cornerRadius,
            borderWidth: self.layer.borderWidth,
            borderColor: self.layer.borderColor,
            shadowColor: self.layer.shadowColor,
            shadowOpacity: self.layer.shadowOpacity,
            shadowOffset: self.layer.shadowOffset,
            shadowRadius: self.layer.shadowRadius,
            shadowPath: self.layer.shadowPath,
            contentMode: self.contentMode
        )
    }
}

