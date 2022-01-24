//
//  UITextFieldExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/1/22.
//

import UIKit

extension UITextField {
	// Borde Inferior UITextField
	func bottomBorder() {
		let bottomLine = CALayer()
		bottomLine.frame = CGRect(x: 0.0, y: self.frame.height, width: self.frame.width, height: 1)
		bottomLine.backgroundColor = UIColor.hardColor?.cgColor
		self.borderStyle = UITextField.BorderStyle.none
		self.layer.addSublayer(bottomLine)
	}
	
	// Estilos Placeholder
	func placeholderStyles(placeHolderText: String) {
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.blueLowOpacity,
			NSAttributedString.Key.font: UIFont(name: FontType.SFProRegular.rawValue, size: 17)
		]
		
		self.attributedPlaceholder = NSAttributedString(
			string: placeHolderText,
			attributes: attributes as [NSAttributedString.Key: Any]
		)
	}
	
	// Estilos Texto
	func textStyles(keyboardType: UIKeyboardType) {
		self.tintColor = .hardColor
		self.keyboardType = keyboardType
	}
}
