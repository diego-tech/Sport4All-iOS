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
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var clubImageView: LazyImageView!
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var typeEventLabel: UILabel!
	@IBOutlet weak var dayEventLabel: UILabel!
	@IBOutlet weak var hourEventLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
				
		// Configure View
		configure()
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización de Estilos
		headerUIView.bottomShadow()
	}
	
	// MARK: Action Functions
	
	
	// MARK: Functions
	private func configure() {
		guard let pendingEvent = pendingEvent else { return debugPrint("Pending Event Error") }
		guard let clubBanner = pendingEvent.clubImg else {
			return debugPrint("Club Banner Error") }
		guard let clubName = pendingEvent.clubName else { return debugPrint("Club Name Error") }
		guard let typeEvent = pendingEvent.sportType else { return debugPrint("Type Club Error") }
		guard let dayEvent = pendingEvent.day else { return debugPrint("Day Error") }
		guard let pendingStartTime = pendingEvent.startTime else { return debugPrint("Hour 1 Error") }
		guard let pendingEndTime = pendingEvent.endTime else { return debugPrint("Hour 2 Error")}
		guard let imgURL = URL(string: Constants.kStorageURL + clubBanner) else { return debugPrint("URL Error") }
		
		self.clubImageView.loadImage(fromURL: imgURL)
		self.clubNameLabel.text = clubName
		self.typeEventLabel.text = typeEvent
		self.dayEventLabel.text = dayEvent
		self.hourEventLabel.text = "\(pendingStartTime) - \(pendingEndTime)"
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
