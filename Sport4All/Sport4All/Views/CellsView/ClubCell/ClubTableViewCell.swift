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
		
		// Inicialización Estilos Vista
		homeClubsUIView.layer.cornerCurve = .circular
		homeClubsUIView.layer.cornerRadius = 10
		homeClubsUIView.backgroundColor = .softBlue
		homeClubsUIView.shadow()
		
		self.backgroundColor = .backgroundColor
    }
	
	func setCellWithValueOf(_ club: Club) {
		updateUI(clubName: club.name, clubPhone: club.tlf, clubImageView: club.club_banner)
	}
	
	private func updateUI(clubName: String?, clubPhone: String?, clubImageView: String?) {
		self.clubNameLabel.text = clubName
		self.clubPhoneLabel.text = clubPhone
		
		let url = URL(string: clubImageView!)
		self.clubImageView.kf.setImage(with: url)
	}
}

/**
 let url = URL(string: "https://example.com/image.png")
 imageView.kf.setImage(with: url)
 */
