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
    
    func scale(by scale: CGFloat) {
        self.contentScaleFactor = scale
        for subview in self.subviews {
            subview.scale(by: scale)
        }
    }
    
    func getImage(scale: CGFloat? = nil) -> UIImage {
        let newScale = scale ?? UIScreen.main.scale
        self.scale(by: newScale)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = newScale
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)
        
        let image = renderer.image { rendererContext in
            self.layer.render(in: rendererContext.cgContext)
        }
        return image
    }
}

extension UIView {
    
    func animateUiViewBack() {
        UIView.animate(withDuration: 0.9, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
            self.transform = .identity
            self.alpha = 1
        })
    }
}

extension UIStackView {
    func animateUiStackViewBack() {
        UIStackView.animate(withDuration: 0.9, delay: 0.1, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseIn, animations: {
            self.transform = .identity
        })
    }
}
