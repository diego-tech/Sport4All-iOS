//
//  UITextFieldExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/1/22.
//

import UIKit

var iconClick = false

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
		self.autocorrectionType = .no
	}
	
	// Ver y Ocultar la Contraseña
	func showAndHidePassword() {
		let imageEye = UIImageView()
		imageEye.image = UIImage(named: "CloseEye")
		
		let contentView = UIView()
		contentView.addSubview(imageEye)
		
		contentView.frame = CGRect(x: 0.0, y: 0.0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye")!.size.height)
		imageEye.frame = CGRect(x: -10.0, y: 0.0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye")!.size.height)
		
		self.rightView = contentView
		self.rightViewMode = .always
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		
		imageEye.isUserInteractionEnabled = true
		imageEye.addGestureRecognizer(tapGestureRecognizer)
	}
	
	// Coger el gesto del usuario al tocar
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		let tappedImage = tapGestureRecognizer.view as! UIImageView
		
		if iconClick {
			iconClick = false
			tappedImage.image = UIImage(named: "OpenEye")
			self.isSecureTextEntry = false
		} else {
			iconClick = true
			tappedImage.image = UIImage(named: "CloseEye")
			self.isSecureTextEntry = true
		}
	}
	
	// Comprobar si el TextField está vació
	func checkIfIsEmpty(placeHolderText: String) -> Bool {
		if self.text == "" {
			placeholderStyles(placeHolderText: placeHolderText)
			bottomBorder(color: .red)
			return true
		} else {
			bottomBorder(color: .hardColor!)
			return false
		}
	}
	
	// Func BottomBorder
	func customSearch(){
		let bottomLine = UIView()
		
		self.borderStyle = .none
		bottomLine.translatesAutoresizingMaskIntoConstraints = false
		bottomLine.backgroundColor = .hardColor
		
		self.addSubview(bottomLine)
		bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 1).isActive = true
		bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		bottomLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true

		self.placeholderRect(forBounds: CGRect(x: -4.0, y: 0, width: 0, height: 0))
		self.placeholderStyles(placeHolderText: "Búsqueda")
		self.textStyles(keyboardType: .default)
		
		let image = UIImageView()
		let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .medium, scale: .unspecified)
		let searchUImage = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfiguration)
		image.image = searchUImage
		
		let contentView = UIView()
		contentView.addSubview(image)
		contentView.frame = CGRect(x: 0.0, y: 0.0, width: searchUImage!.size.width, height: searchUImage!.size.height)
		image.frame = CGRect(x: -2.0, y: 0.0, width: searchUImage!.size.width, height: searchUImage!.size.height)
		self.leftView = contentView
		self.leftViewMode = .always
	}
}
