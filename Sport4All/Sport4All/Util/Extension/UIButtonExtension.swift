//
//  UIButtonExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/1/22.
//

import UIKit

extension UIButton {
	
	// Redondeo del bottom
	func  round() {
		self.layer.cornerCurve = .circular
		self.layer.cornerRadius = 10
	}
	
	// Colores
	func colors() {
		self.backgroundColor = .periwinkle
		self.tintColor = .hardColor
	}
}
