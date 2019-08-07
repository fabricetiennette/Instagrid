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

    func animateAndMove(y: CGFloat, x: CGFloat) {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(translationX: x, y: y)
        })
    }
    
    func animateBack(x: CGFloat, y: CGFloat) {
        if UIDevice.current.orientation.isLandscape {
            self.transform = CGAffineTransform(translationX: x, y: y)
        } else if UIDevice.current.orientation.isPortrait {
            self.transform = CGAffineTransform(translationX: y, y: x)
        }
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
                self.transform = .identity
        })
    }
}
