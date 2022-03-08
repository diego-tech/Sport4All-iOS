//
//  YourClubEventsTableViewCell.swift
//  Sport4All
//
//  Created by Javier González Delmas on 21/2/22.
//

import UIKit

class YourClubEventsTableViewCell: UITableViewCell {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var yourEventUIView: UIView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización Estilos
		uiViewStyles()
		self.backgroundColor = .backgroundColor
    }


	
	// MARK: Styles
	private func uiViewStyles() {
		yourEventUIView.layer.cornerCurve = .circular
		yourEventUIView.layer.cornerRadius = 10
		yourEventUIView.backgroundColor = .softBlue
		yourEventUIView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
