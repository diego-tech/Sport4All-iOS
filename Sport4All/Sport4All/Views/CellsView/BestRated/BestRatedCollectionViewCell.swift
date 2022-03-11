//
//  BestRatedCollectionViewCell.swift
//  Sport4All
//
//  Created by Cristobal Lletget Luque on 2/2/22.
//

import UIKit

protocol ReserveButtonTap {
	func buttonTapped(_ cell: UICollectionViewCell, clubID: Int)
}

class BestRatedCollectionViewCell: UICollectionViewCell {
	
	// Variables
	var reserveButtonDelegate: ReserveButtonTap?
	var clubId: Int?
	
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
		guard let finalClubID = clubId else { return }
		reserveButtonDelegate?.buttonTapped(self, clubID: finalClubID)
	}
	
	// MARK: Functions
	func setItemWithValueOf(_ club: Club) {
		updateUI(clubName: club.name, clubImageStr: club.club_img)
		guard let club_id = club.id else { return }
		clubId = club_id
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
