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
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
	}
	
	// MARK: Functions
	func setItemWithValueOf(_ price: Price) {
		let stringPrice = String(price.price)
		let stringTime = String(price.time)
		updateUI(priceLabel: stringPrice, timeLabel: stringTime)
	}
	
	private func updateUI(priceLabel: String?, timeLabel: String?) {
		guard let priceLabel = priceLabel else { return }
		guard let timeLabel = timeLabel else { return }
		self.priceLabel.text = priceLabel + " Є"
		self.timeLabel.text = timeLabel + " Min"
	}
	
	// MARK: Styles
	private func uiViewStyles() {
		priceCVCView.layer.cornerCurve = .circular
		priceCVCView.layer.cornerRadius = 12
		priceCVCView.backgroundColor = .softBlue
		priceCVCView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
