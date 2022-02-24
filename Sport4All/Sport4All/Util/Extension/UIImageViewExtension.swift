//
//  UIImageViewExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 20/2/22.
//

import UIKit

extension UIImageView {
	
	// Imagen Redonda
	func makeRounds() {
		self.layer.borderWidth = 0
		self.layer.masksToBounds = false
		self.layer.cornerRadius = self.frame.height / 2
		self.clipsToBounds = true
	}
	
	// Redondeo de dos bordes
	public func roundOnlyTwoCorners(_ corners: UIRectCorner, radius: CGFloat) {
		let maskPath = UIBezierPath(roundedRect: bounds,
									byRoundingCorners: corners,
									cornerRadii: CGSize(width: radius, height: radius))
		let shape = CAShapeLayer()
		shape.path = maskPath.cgPath
		layer.mask = shape
	}
}
