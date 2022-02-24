//
//  ClubTableViewCell.swift
//  Sport4All
//
//  Created by Javier González Delmas on 8/2/22.
//

import UIKit
import Kingfisher

class ClubTableViewCell: UITableViewCell {

	// Variables

	// Outlets
	@IBOutlet weak var homeClubsUIView: UIView!
	@IBOutlet weak var clubImageView: UIImageView!
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
		updateUI(clubName: club.name, clubPhone: club.tlf, clubImageView: club.club_img)
	}
	
	private func updateUI(clubName: String?, clubPhone: String?, clubImageView: String?) {
		guard let clubImageView = clubImageView else { return }

		self.clubNameLabel.text = clubName
		self.clubPhoneLabel.text = clubPhone

		let url = URL(string: clubImageView)
		self.clubImageView.kf.setImage(with: url, placeholder: UIImage(named: "All Clubs Image"))
	}
	
	// MARK: Styles
	private func uiViewStyles() {
		homeClubsUIView.layer.cornerCurve = .circular
		homeClubsUIView.layer.cornerRadius = 10
		homeClubsUIView.backgroundColor = .softBlue
		homeClubsUIView.shadow()
	}
}
