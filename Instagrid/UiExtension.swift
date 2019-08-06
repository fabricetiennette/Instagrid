//
//  UIViewExtension.swift
//  Instagrid
//
//  Created by Fabrice Etiennette on 22/07/2019.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func flashAnimation() {
        let flash = CABasicAnimation(keyPath: "opacity")
        
        flash.duration = 0.1
        flash.fromValue = 0.6
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        
        layer.add(flash, forKey: nil)
    }
}

extension UIView {
    func animateAndMoveUiView(y: CGFloat, x: CGFloat) {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(translationX: x, y: y)
            self.alpha = 0
        })
    }
    
    func animateUiViewBack() {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
            self.transform = .identity
            self.alpha = 1
        })
    }
}

extension UIStackView {
    func animateAndMoveStackView(y: CGFloat, x: CGFloat) {
        UIStackView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(translationX: x, y: y)
        })
    }
    
    func animateUiStackViewBack() {
        UIStackView.animate(withDuration: 0.9, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
            self.transform = .identity
        })
    }
}
