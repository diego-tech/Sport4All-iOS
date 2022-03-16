//
//  DetailEventViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/2/22.
//

import UIKit
import MapKit

class DetailEventViewController: UIViewController {
	
	// MARK: Variables
	var event: Event?
	
	// MARK: Outlets
	@IBOutlet weak var eventNameLabel: UILabel!
	@IBOutlet weak var eventImageView: LazyImageView!
	@IBOutlet weak var eventDayLabel: UILabel!
	@IBOutlet weak var infoEventTextView: UITextView!
	@IBOutlet weak var clubDirection: MKMapView!
	@IBOutlet weak var inscribeEventBTN: UIButton!
	@IBOutlet weak var headerUIView: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización Estilos
		inscribeButtonStyle()
		headerUIView.bottomShadow()
		
		// Configure View
		configure()
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func configure() {
		guard let event = event else { return }
		guard let event_img = event.img else { return }
//		guard let event_desc = event.description else { return }
//		guard let location = event.clubLocation else { return }
		guard let eventName = event.name else { return }
		guard let eventUrl = URL(string: Constants.kStorageURL + event_img) else { return }
		
		self.eventImageView.loadImage(fromURL: eventUrl)
		self.eventNameLabel.text = eventName
	}
	
	// MARK: Styles
	private func inscribeButtonStyle() {
		inscribeEventBTN.round()
		inscribeEventBTN.colors()
	}
	
	private func configureNavbar() {
		self.navigationController?.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "EVENTO"
		
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
