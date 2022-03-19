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
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var courtNameLabel: UILabel!
	@IBOutlet weak var matchPriceLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
    }

	
	// MARK: Functions
	func setCellWithValueOf(_ matchItem: MatchItem) {
		updateUI(clubName: matchItem.club?.name, courtName: matchItem.court?.name, matchPrice: matchItem.pricePeople, courtSurface: matchItem.court?.type, courtType: matchItem.court?.surfaces)
	}
	
	private func updateUI(clubName: String?, courtName: String?, matchPrice: Int?, courtSurface: String?, courtType: String?) {
		guard let clubName = clubName else { return }
		guard let courtName = courtName else { return }
		guard let matchPrice = matchPrice else { return }
		guard let courtSurface = courtSurface else { return }
		guard let courtType = courtType else { return }
		
		self.clubNameLabel.text = clubName
		self.courtNameLabel.text = "\(courtName) (\(courtSurface), \(courtType))"
		self.matchPriceLabel.text = "Precio: \(matchPrice) Є"
	}
	
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
