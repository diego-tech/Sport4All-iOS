//
//  MatchesMainTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import UIKit

class MatchesMainTableViewCell: UITableViewCell {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var uiView: UIView!
	@IBOutlet weak var dayTimeLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
    }

    // MARK: Functions
	
	
	// MARK: Styles
	private func uiViewStyles() {
		uiView.layer.cornerCurve = .circular
		uiView.layer.cornerRadius = 10
		uiView.backgroundColor = .softBlue
		uiView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
