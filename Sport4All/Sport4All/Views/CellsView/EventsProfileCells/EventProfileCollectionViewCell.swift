//
//  EventProfileCollectionViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 14/3/22.
//

import UIKit

class EventProfileCollectionViewCell: UICollectionViewCell {
    
	// MARK: Variables
	
	
	// MARK: Outlets
	@IBOutlet weak var eventImageView: LazyImageView!
	@IBOutlet weak var eventNameLabel: UILabel!
	@IBOutlet weak var uiViewCollectionViewProfile: UIView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization Code
		
		// Inicialización de Estilos
		uiViewStyles()
		imageViewStyles()
	}
	
	// MARK: Functions
	func setItemWithValueOf(_ pendingMatch: PendingEvent, pendingType: PendingType) {
		
		switch pendingType {
		case .match:
			updateUI(eventImage: pendingMatch.clubImg, eventName: pendingMatch.clubName)
		case .event:
			updateUI(eventImage: pendingMatch.eventImg, eventName: pendingMatch.eventName)
		case .reserve:
			updateUI(eventImage: pendingMatch.clubImg, eventName: pendingMatch.clubName)
		}
	}
	
	private func updateUI(eventImage: String?, eventName: String?) {
		guard let eventName = eventName else { return debugPrint("Event Name Error") }
		guard let eventImage = eventImage else { return debugPrint("Event Image Error") }
		guard let url = URL(string: Constants.kStorageURL + eventImage) else { return }
		
		self.eventImageView.loadImage(fromURL: url)
		self.eventNameLabel.text = eventName
	}
	
	// MARK: Styles
	private func uiViewStyles() {
		uiViewCollectionViewProfile.layer.cornerCurve = .circular
		uiViewCollectionViewProfile.layer.cornerRadius = 10
		uiViewCollectionViewProfile.backgroundColor = .softBlue
		uiViewCollectionViewProfile.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
	
	private func imageViewStyles() {
		eventImageView.makeRounds()
	}
}
