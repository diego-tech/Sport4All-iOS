//
//  PayResumeViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

enum ReserveType {
	case courtReserve
	case matchReserve
}

class PayResumeViewController: UIViewController {
	
	// MARK: Variables
	var reserveType: ReserveType?
	
	var club: Club?
	var court: Court?
	var price: Price?
	var match: MatchItem?
	var reserveDay: String?
	var reserveHour: String?
	
	var court_id: Int = 0
	var day: String = ""
	var start_time: String = ""
	var time: Int = 0
	
	var matchId: Int = 0
	
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
		switch reserveType {
		case .courtReserve:
			courtReservePay()
		case .matchReserve:
			matchReservePay()
		default:
			break
		}
	}
	
	// MARK: Functions
	private func configure() {
		switch reserveType {
		case .courtReserve:
			configureCourtReserve()
		case .matchReserve:
			configureMatchReserve()
		default:
			break
		}
	}
	
	private func configureCourtReserve() {
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
		
		guard let intTime = Int(timeString) else { return }
		self.time = intTime
	}
	
	private func configureMatchReserve() {
		guard let match = match else { return debugPrint("Error Match") }
		guard let matchId = match.id else { return debugPrint("Error Match id") }
		guard let clubName = match.club?.name else { return debugPrint("Club Name") }
		guard let courtName = match.court?.name else { return debugPrint("Court Name") }
		guard let courtType = match.court?.type else { return debugPrint("Court Type") }
		guard let courtSport = match.court?.sport else { return debugPrint("Court Sport") }
		guard let courtSurface = match.court?.surfaces else { return debugPrint("Court Surface") }
		guard let reserveDay = reserveDay else { return debugPrint("Reserve Day") }
		guard let price = match.pricePeople else { return debugPrint("Reserve Time") }
		guard let startTime = match.startTime else { return debugPrint("Start Time") }
		guard let endTime = match.endTime else { return debugPrint("End Time") }
		
		// Setting Values in UI
		self.clubNameLabel.text = clubName
		self.courtNameLabel.text = courtName
		self.courtInfoLabel.text = "\(courtSport): \(courtType), \(courtSurface)"
		self.reserveDayLabel.text = reserveDay
		self.reserveHourLabel.text = "\(startTime) - \(endTime)"
		self.reserveDurationLabel.isHidden = true
		
		let priceString = String(price)
		self.reservePriceLabel.text = priceString + " €"
		
		self.matchId = matchId
	}
	
	private func courtReservePay() {
		guard let clubId = club?.id else { return }
		print("Tiempo Variable \(time)")
		let reserveQuery = ReserveQuery(club_id: clubId, court_id: court_id, day: day, start_time: start_time, time: time)
		
		print("Reserva \(reserveQuery)")
		
		NetworkingProvider.shared.courtReserve(reserveQuery: reserveQuery) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func matchReservePay() {
		NetworkingProvider.shared.matchInscription(match_id: matchId) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: Styles
	private func payButtonStyles() {
		payButton.round()
	}
}
