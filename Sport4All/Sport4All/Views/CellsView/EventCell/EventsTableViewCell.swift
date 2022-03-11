//
//  EventsTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 11/3/22.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

	@IBOutlet weak var eventsUIView: UIView!
	@IBOutlet weak var eventsIV: LazyImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
		eventsIV.roundOnlyTwoCorners([.bottomLeft, .topLeft], radius: 10)
		self.backgroundColor = .backgroundColor
    }
	
	// MARK: Functions
	func setCellWithValueOf() {
		
	}

	// MARK: Styles
	private func uiViewStyles() {
		eventsUIView.layer.cornerCurve = .circular
		eventsUIView.layer.cornerRadius = 10
		eventsUIView.backgroundColor = .softBlue
		eventsUIView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
