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
}
