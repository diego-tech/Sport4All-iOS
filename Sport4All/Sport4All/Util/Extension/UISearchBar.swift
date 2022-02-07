//
//  UISearchBar.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 7/2/22.
//

import UIKit

extension UISearchBar {
	
	// Func BottomBorder
	func bottomBorder(color: UIColor){
		let bottomLine = UIView()
		
		self.searchTextField.borderStyle = .none
		bottomLine.translatesAutoresizingMaskIntoConstraints = false
		bottomLine.backgroundColor = color
		
		self.addSubview(bottomLine)
		bottomLine.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
		bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		bottomLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
	}
}
  
