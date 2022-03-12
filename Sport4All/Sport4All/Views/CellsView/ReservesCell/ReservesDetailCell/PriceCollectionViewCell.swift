//
//  PriceCollectionViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 12/3/22.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var priceCVCView: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
	}
	
	// MARK: Functions
	
	// MARK: Styles
	private func uiViewStyles() {
		priceCVCView.layer.cornerCurve = .circular
		priceCVCView.layer.cornerRadius = 12
		priceCVCView.backgroundColor = .softBlue
		priceCVCView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
