//
//  EventProfileCollectionViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 14/3/22.
//

import UIKit

class EventProfileCollectionViewCell: UICollectionViewCell {
    
	// MARK: Variables
	
	
	// MARK: Outlets
	@IBOutlet weak var clubImageView: UIImageView!
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var uiViewCollectionViewProfile: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization Code
		
		// Inicialización de Estilos
		uiViewStyles()
	}
	
	
	// MARK: Styles
	private func uiViewStyles() {
		uiViewCollectionViewProfile.layer.cornerCurve = .circular
		uiViewCollectionViewProfile.layer.cornerRadius = 10
		uiViewCollectionViewProfile.backgroundColor = .softBlue
		uiViewCollectionViewProfile.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
