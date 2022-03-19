//
//  MatchesDetailTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import UIKit

class MatchesDetailTableViewCell: UITableViewCell {

	// MARK: Variables
	private var users: [User] = [User]()
	
	// MARK: Outlets
	@IBOutlet weak var backgroundUIView: UIView!
	@IBOutlet weak var mainUiView: UIView!
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var courtNameLabel: UILabel!
	@IBOutlet weak var matchPriceLabel: UILabel!
	@IBOutlet weak var userImagesCollectionView: UICollectionView!
	@IBOutlet weak var courtSportLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
		
		// Inicialización Collection View
		initCollectionView()
    }

	
	// MARK: Functions
	func setCellWithValueOf(_ matchItem: MatchItem) {
		updateUI(clubName: matchItem.club?.name, courtName: matchItem.court?.name, matchPrice: matchItem.pricePeople, courtType: matchItem.court?.type, courtSurface: matchItem.court?.surfaces, courtSport: matchItem.court?.sport)
		guard let users = matchItem.users else { return }
		self.users = users
		
		DispatchQueue.main.async {
			self.userImagesCollectionView.reloadData()
		}
	}
	
	private func updateUI(clubName: String?, courtName: String?, matchPrice: Int?, courtType: String?, courtSurface: String?, courtSport: String?) {
		guard let clubName = clubName else { return }
		guard let courtName = courtName else { return }
		guard let matchPrice = matchPrice else { return }
		guard let courtSurface = courtSurface else { return }
		guard let courtSport = courtSport else { return }
		guard let courtType = courtType else { return }
		
		self.clubNameLabel.text = clubName
		self.courtNameLabel.text = "\(courtName) (\(courtType))"
		self.matchPriceLabel.text = "Precio: \(matchPrice) Є"
		self.courtSportLabel.text = courtSport + ": " + courtSurface
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
	
	private func initCollectionView() {
		userImagesCollectionView.backgroundColor = .clear
		userImagesCollectionView.dataSource = self
		userImagesCollectionView.delegate = self
		userImagesCollectionView.isScrollEnabled = true
		userImagesCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
		userImagesCollectionView.showsVerticalScrollIndicator = false
		userImagesCollectionView.showsHorizontalScrollIndicator = false
		userImagesCollectionView.reloadData()
	}
}

// MARK: Delegate and DataSource UICollectionView
extension MatchesDetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return users.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UsersMatchCollectionViewCell", for: indexPath) as? UsersMatchCollectionViewCell else { return UICollectionViewCell() }
		let user = users[indexPath.item]
		cell.setItemWithValueOf(user)
		
		return cell
	}
	
	/* Márgenes entre las celdas */
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
		return inset
	}
}
