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
	func setItemWithValueOf(_ pendingOrFinish: PendingOrFinishEvent, pendingType: PendingType) {
		
		switch pendingType {
		case .match:
			updateUI(eventImage: pendingOrFinish.clubImg, eventName: pendingOrFinish.clubName)
		case .event:
			updateUI(eventImage: pendingOrFinish.eventImg, eventName: pendingOrFinish.eventName)
		case .reserve:
			updateUI(eventImage: pendingOrFinish.clubImg, eventName: pendingOrFinish.clubName)
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
