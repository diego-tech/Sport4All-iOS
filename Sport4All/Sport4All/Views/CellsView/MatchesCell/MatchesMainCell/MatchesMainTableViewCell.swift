//
//  MatchesMainTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import UIKit

class MatchesMainTableViewCell: UITableViewCell {
	
	// MARK: Variables
	private var startTime: String?
	
	// MARK: Outlets
	@IBOutlet weak var uiView: UIView!
	@IBOutlet weak var dayTimeLabel: UILabel!
	@IBOutlet weak var arrowImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
		// Inicialización de Estilos
		uiViewStyles()
	}
	
	// MARK: Functions
	func setCellWithValueOf(_ match: Match) {
		self.startTime = match.startTime
		guard let startTime = startTime else { return }
		
		let startTimeFormatted = dateFormatter(startTime: startTime)
		updateUI(dayTime: startTimeFormatted)
	}
	
	private func updateUI(dayTime: String?) {
		guard let dayTime = dayTime else { return }
		
		self.dayTimeLabel.text = dayTime
	}
	
	private func dateFormatter(startTime: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss"
		let startTimeFormat = formatter.date(from: startTime)
		
		guard let startTimeFormat = startTimeFormat else { return "" }
		formatter.locale = Locale(identifier: "es_Es")
		formatter.dateFormat = "HH:mm"
		let formatterStarTime = formatter.string(from: startTimeFormat)
		
		return "Hora: \(formatterStarTime)"
	}
	
	// MARK: Styles
	private func uiViewStyles() {
		uiView.layer.cornerCurve = .circular
		uiView.layer.cornerRadius = 10
		uiView.backgroundColor = .softBlue
		uiView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
