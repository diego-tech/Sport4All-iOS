//
//  UISearchBar.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 7/2/22.
//

import UIKit

extension UITextField {
	
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

		self.placeholderRect(forBounds: CGRect(x: -3.0, y: 0, width: 0, height: 0))
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
  
