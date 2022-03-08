//
//  ClubTableViewCell.swift
//  Sport4All
//
//  Created by Javier González Delmas on 8/2/22.
//

import UIKit

class ClubTableViewCell: UITableViewCell {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var homeClubsUIView: UIView!
	@IBOutlet weak var clubImageView: LazyImageView!
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var clubPhoneLabel: UILabel!
	@IBOutlet weak var servicesStackView: UIStackView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		// Inicialización Estilos
		uiViewStyles()
		clubImageView.roundOnlyTwoCorners([.bottomLeft, .topLeft], radius: 10)
		self.backgroundColor = .backgroundColor
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	func setCellWithValueOf(_ club: Club) {
		updateUI(clubName: club.name, clubPhone: club.tlf, clubImageStr: club.club_img, services: club.services)
	}
	
	private func updateUI(clubName: String?, clubPhone: String?, clubImageStr: String?, services: [ClubService]?) {		
		guard let clubImageStr = clubImageStr else { return print("Hola") }
		guard let services = services else { return print("Hola") }
		guard let url = URL(string: Constants.kStorageURL + clubImageStr) else { return print("Hola") }

		self.clubNameLabel.text = clubName
		self.clubPhoneLabel.text = clubPhone
		self.servicesStackView.setServicesInStackView(services: services, imageSize: CGRect(x: 0, y: 0, width: 50, height: 50))
		self.clubImageView.loadImage(fromURL: url)
	}
	
	
	// MARK: Styles
	private func uiViewStyles() {
		homeClubsUIView.layer.cornerCurve = .circular
		homeClubsUIView.layer.cornerRadius = 10
		homeClubsUIView.backgroundColor = .softBlue
		homeClubsUIView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
