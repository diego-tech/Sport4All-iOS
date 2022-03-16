//
//  EventsTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 11/3/22.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var eventsUIView: UIView!
	@IBOutlet weak var eventsIV: LazyImageView!
	@IBOutlet weak var eventImageView: LazyImageView!
	@IBOutlet weak var eventNameLabel: UILabel!
	@IBOutlet weak var clubNameLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
		eventsIV.roundOnlyTwoCorners([.bottomLeft, .topLeft], radius: 10)
		self.backgroundColor = .backgroundColor
    }
	
	// MARK: Functions
	func setCellWithValueOf(_ event: Event) {
		updateUI(eventName: event.name, clubName: event.clubName, eventImageStr: event.img)
	}
	
	private func updateUI(eventName: String?, clubName: String?, eventImageStr: String?) {
		guard let eventName = eventName else { return print("event name error") }
		guard let clubName = clubName else { return print("club name error") }
		guard let eventImageStr = eventImageStr else { return print("event img error") }
		guard let url = URL(string: Constants.kStorageURL + eventImageStr) else { return }
		
		self.eventNameLabel.text = eventName
		self.clubNameLabel.text = clubName
		self.eventImageView.loadImage(fromURL: url)
	}

	// MARK: Styles
	private func uiViewStyles() {
		eventsUIView.layer.cornerCurve = .circular
		eventsUIView.layer.cornerRadius = 10
		eventsUIView.backgroundColor = .softBlue
		eventsUIView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
