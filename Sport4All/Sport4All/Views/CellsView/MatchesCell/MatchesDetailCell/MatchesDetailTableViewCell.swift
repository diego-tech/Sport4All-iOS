//
//  MatchesDetailTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import UIKit

class MatchesDetailTableViewCell: UITableViewCell {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var backgroundUIView: UIView!
	@IBOutlet weak var mainUiView: UIView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
    }

	
	// MARK: Functions
	
	
	// MARK: Styles
	
	private func uiViewStyles() {
		// Main UI View Styles
		mainUiView.layer.cornerCurve = .circular
		mainUiView.layer.cornerRadius = 10
		mainUiView.backgroundColor = .blueBerry
		mainUiView.shadow(shadowOpacity: 0.30, shadowRadius: 6)
		
		// Background UI View Styles
		backgroundUIView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
	}
}
