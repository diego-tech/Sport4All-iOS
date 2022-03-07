//
//  UIImageViewExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 20/2/22.
//

import UIKit

var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
var blurEffectView = UIVisualEffectView()

extension UIImageView {
	
	// Imagen Redonda
	func makeRounds() {
		self.layer.borderWidth = 0
		self.layer.masksToBounds = false
		self.layer.cornerRadius = self.frame.height / 2
		self.clipsToBounds = true
	}
	
	// Redondeo de dos bordes
	func roundOnlyTwoCorners(_ corners: UIRectCorner, radius: CGFloat) {
		let maskPath = UIBezierPath(roundedRect: bounds,
									byRoundingCorners: corners,
									cornerRadii: CGSize(width: radius, height: radius))
		let shape = CAShapeLayer()
		shape.path = maskPath.cgPath
		layer.mask = shape
	}
	
	// Efecto Blur cuando carguen las imágenes
	func setBlurEffect() {
		blurEffectView.effect = blurEffect
		blurEffectView.frame = self.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.addSubview(blurEffectView)
	}
	
	// Efecto Blur Alpha 0
	func setBlurAlpha0Effect() {
		UIView.animate(withDuration: 0.4, delay: 0.4, options: .curveEaseInOut) {
			blurEffectView.alpha = 0
		}
	}
}
