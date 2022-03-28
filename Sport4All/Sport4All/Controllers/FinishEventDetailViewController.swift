//
//  FinishEventDetailViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import UIKit

class FinishEventDetailViewController: UIViewController {
	
	// MARK: Variables
	var pendingEvent: PendingOrFinishEvent?
	var pendingType: PendingType?
	var clubId: Int = 0
	var club: Club?
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var clubImageView: LazyImageView!
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var typeEventLabel: UILabel!
	@IBOutlet weak var dayEventLabel: UILabel!
	@IBOutlet weak var hourEventLabel: UILabel!
	@IBOutlet weak var infoClubButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Configure View
		configure()
		
		// Fetch Club Info
		fetchClubInfo()
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización de Estilos
		headerUIView.bottomShadow()
	}
	
	// MARK: Action Functions
	@IBAction func goToInfoClubButtonAction(_ sender: UIButton) {
		let vc = UIStoryboard(name: "InfoClub", bundle: nil).instantiateViewController(withIdentifier: "InfoClub") as! InfoClubViewController
		vc.club = club
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction func goToInfoWebButtonAction(_ sender: UIButton) {
		guard let web = club?.web else { return }
		if let urlToOpen = URL(string: web) {
			UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil )
		}
	}
	
	@IBAction func goToCallClubButtonAction(_ sender: UIButton) {
		guard let tlf = club?.tlf else { return }
		if let urlToOpen = URL(string: "tel://\(tlf)") {
			UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil )
		}
	}
	
	// MARK: Functions
	private func configure() {
		guard let pendingEvent = pendingEvent else { return debugPrint("Pending Event Error") }
		guard let clubId = pendingEvent.clubId else { return debugPrint("Club Id Error") }
		guard let clubBanner = pendingEvent.clubImg else {
			return debugPrint("Club Banner Error") }
		guard let clubName = pendingEvent.clubName else { return debugPrint("Club Name Error") }
		guard let typeEvent = pendingEvent.sportType else { return debugPrint("Type Club Error") }
		guard let dayEvent = pendingEvent.day else { return debugPrint("Day Error") }
		guard let pendingStartTime = pendingEvent.startTime else { return debugPrint("Hour 1 Error") }
		guard let pendingEndTime = pendingEvent.endTime else { return debugPrint("Hour 2 Error")}
		guard let imgURL = URL(string: Constants.kStorageURL + clubBanner) else { return debugPrint("URL Error") }
		
		self.clubId = clubId
		self.clubImageView.loadImage(fromURL: imgURL)
		self.clubNameLabel.text = clubName
		self.typeEventLabel.text = typeEvent
		self.dayEventLabel.text = dayEvent
		self.hourEventLabel.text = "\(pendingStartTime) - \(pendingEndTime)"
	}
	
	private func fetchClubInfo() {
		NetworkingProvider.shared.infoClub(club_id: clubId) { responseData, status, msg in
			guard let club = responseData else { return }
			if status == 1 {
				self.club = club
			} else {
				self.infoClubButton.isEnabled = false
			}
		} failure: { error in
			guard let error = error else { return }
			debugPrint("Fetch Club Info Error \(error)")
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
			vc.modalPresentationStyle = .fullScreen
			vc.modalTransitionStyle = .coverVertical
			vc.errorType = .decodingError
			self.present(vc, animated: true, completion: nil)
		}
	}
	
	// MARK: Styles
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "INSCRIPCION"
		
		let yourBackImage = UIImage(systemName: "arrowshape.turn.up.backward.fill", withConfiguration:  UIImage.SymbolConfiguration(pointSize: 18))
		let backButtonItem = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(popView(tapGestureRecognizer:)))
		backButtonItem.tintColor = .corporativeColor
		
		self.navigationItem.leftBarButtonItem = backButtonItem
		
		self.navigationItem.setHidesBackButton(true, animated: true)
	}
	
	@objc func popView(tapGestureRecognizer: UITapGestureRecognizer) {
		self.navigationController?.popViewController(animated: true)
	}
}
