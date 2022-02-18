//
//  UIViewExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 18/2/22.
//

import UIKit

extension UIView {
	
	// Sobra UIView
	func viewShadow() {
		self.layer.masksToBounds = false
		self.layer.shadowRadius = 3
		self.layer.shadowOpacity = 0.2
		self.layer.shadowColor = UIColor.gray.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 4)
		self.layer.zPosition = 1
	}
}
