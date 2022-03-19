//
//  PayResumeViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class PayResumeViewController: UIViewController {
	
	// MARK: Variables
	var club: Club?
	var court: Court?
	var price: Price?
	var reserveDay: String?
	var reserveHour: String?
	
	var court_id: Int = 0
	var day: String = ""
	var start_time: String = ""
	var time: Int = 0
	
	// MARK: Outlets
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var courtNameLabel: UILabel!
	@IBOutlet weak var courtInfoLabel: UILabel!
	@IBOutlet weak var reserveDayLabel: UILabel!
	@IBOutlet weak var reserveHourLabel: UILabel!
	@IBOutlet weak var reserveDurationLabel: UILabel!
	@IBOutlet weak var reservePriceLabel: UILabel!
	@IBOutlet weak var payButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

		// Init Styles
		payButtonStyles()
		
		// Init Configure
		configure()
    }
	
	override func updateViewConstraints() {
		let height: CGFloat = 610
		self.view.frame.size.height = height
		self.view.frame.origin.y = UIScreen.main.bounds.height - height
		
		self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
		
		super.updateViewConstraints()
	}
	
	// MARK: Action Functions
	@IBAction func payButtonAction(_ sender: UIButton) {
		let reserveQuery = ReserveQuery(court_id: court_id, day: day, start_time: start_time, time: time)
		
		print("Reserva \(reserveQuery)")
		
		NetworkingProvider.shared.courtReserve(reserveQuery: reserveQuery) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: Functions
	private func configure() {
		guard let club = club else { return }
		guard let court = court else { return }
		guard let price = price else { return }

		guard let courtId = court.id else { return }
		
		guard let clubName = club.name else { return }
		guard let courtName = court.name else { return }
		guard let courtType = court.type else { return }
		guard let courtSport = court.sport else { return }
		guard let courtSurface = court.surfaces else { return }
		guard let reserveDay = reserveDay else { return }
		guard let reserveHour = reserveHour else { return }
		

		let timeString = String(price.time)
		let priceString = String(price.price)

		// Setting Values in UI
		self.clubNameLabel.text = clubName
		self.courtNameLabel.text = courtName
		self.courtInfoLabel.text = "\(courtSport): \(courtType), \(courtSurface)"
		self.reserveDayLabel.text = reserveDay
		self.reserveHourLabel.text = reserveHour
		self.reserveDurationLabel.text = timeString + " Minutos"
		self.reservePriceLabel.text = priceString + " €"
		
		// Settings Values in Variables
		self.court_id = courtId
		self.day = reserveDay
		self.start_time = reserveHour
		
		guard let priceInt = Int(priceString) else { return }
		self.time = priceInt
	}
	
	// MARK: Styles
	private func payButtonStyles() {
		payButton.round()
	}
}
