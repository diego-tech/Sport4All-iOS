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
	public var isLoading: Bool = true
	
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
		updateUI(clubName: club.name, clubPhone: club.tlf, clubImageStr: club.club_img, services: club.services)
	}
	
	private func updateUI(clubName: String?, clubPhone: String?, clubImageStr: String?, services: [ClubService]?) {
		guard let clubImageStr = clubImageStr else { return }
		guard let services = services else { return }

		self.clubNameLabel.text = clubName
		self.clubPhoneLabel.text = clubPhone
		self.setStackView(services: services)
		
		let url = URL(string: clubImageStr)
		self.clubImageView.kf.setImage(with: url, placeholder: UIImage(named: "All Clubs Image"))
	}
	
	private func setStackView(services: [ClubService]) {
		servicesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		var servicesImages = [UIImage()]
		
		for service in services {
			servicesImages.append(GetServices.getServices(clubService: service))
		}
				
		for servicesImage in servicesImages {
			let serviceImageView: UIImageView = {
				let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 21, height: 20))
				image.tintColor = .corporativeColor
				return image
			}()
			serviceImageView.image = servicesImage
			servicesStackView.addArrangedSubview(serviceImageView)
		}
	}
	
	// MARK: Styles
	private func uiViewStyles() {
		homeClubsUIView.layer.cornerCurve = .circular
		homeClubsUIView.layer.cornerRadius = 10
		homeClubsUIView.backgroundColor = .softBlue
		homeClubsUIView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
