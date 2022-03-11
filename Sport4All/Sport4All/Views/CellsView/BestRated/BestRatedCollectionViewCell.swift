//
//  BestRatedCollectionViewCell.swift
//  Sport4All
//
//  Created by Cristobal Lletget Luque on 2/2/22.
//

import UIKit

protocol ReserveButtonTap {
	func buttonTapped(_ cell: UICollectionViewCell, club: Club)
}

class BestRatedCollectionViewCell: UICollectionViewCell {
	
	// Variables
	var reserveButtonDelegate: ReserveButtonTap?
	var reserveClub: Club?
	
	// Outlets
	@IBOutlet weak var bestRatedView: UIView!
	@IBOutlet weak var bestRatedIV: LazyImageView!
	@IBOutlet weak var bestRatedLabel: UILabel!
	@IBOutlet weak var bestRatedReserveBTN: UIButton!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
		buttonStyles()
		imageViewStyles()
    }
	
	@IBAction func reserveButtonAction(_ sender: UIButton) {
		guard let reserveClub = reserveClub else { return }
		reserveButtonDelegate?.buttonTapped(self, club: reserveClub)
	}
	
	// MARK: Functions
	func setItemWithValueOf(_ club: Club) {
		updateUI(clubName: club.name, clubImageStr: club.club_img)
		reserveClub = club
	}
	
	private func updateUI(clubName: String?, clubImageStr: String?) {
		guard let clubImageStr = clubImageStr else { return }
		guard let clubName = clubName else { return }
		guard let url = URL(string: Constants.kStorageURL + clubImageStr) else { return }

		self.bestRatedIV.loadImage(fromURL: url)
		self.bestRatedLabel.text = clubName
	}
	
	// MARK: Styles
	private func uiViewStyles() {
		bestRatedView.layer.cornerCurve = .circular
		bestRatedView.layer.cornerRadius = 10
		bestRatedView.backgroundColor = .softBlue
		bestRatedView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
	
	private func buttonStyles() {
		bestRatedReserveBTN.layer.cornerCurve = .circular
		bestRatedReserveBTN.layer.cornerRadius = 5
	}
	
	private func imageViewStyles() {
		bestRatedIV.makeRounds()
	}
}
