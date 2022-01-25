//
//  UITextFieldExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/1/22.
//

import UIKit

extension UITextField {

	// Borde Inferior UITextField
	func bottomBorder(color: UIColor){
		let bottomLine = UIView()
		
		self.borderStyle = .none
		bottomLine.translatesAutoresizingMaskIntoConstraints = false
		bottomLine.backgroundColor = color
		
		self.addSubview(bottomLine)
		bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
		bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		bottomLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
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
