//
//  PendingEventsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class PendingEventsViewController: UIViewController {
	
	// MARK: Variables
	var pendingEvent: PendingOrFinishEvent?
	var pendingType: PendingType?
	
	// MARK: Matches and Reserves Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var barcodeImageView: UIImageView!
	
	// MARK: Events Outlest
	@IBOutlet weak var eventHeaderUIView: UIView!
	@IBOutlet weak var eventImageView: LazyImageView!
	@IBOutlet weak var eventNameLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización de Estilos
		headerUIView.bottomShadow()
		eventHeaderUIView.bottomShadow()
		barcodeIVStyle()
		
		// Configure
		configure()
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func configure() {
		switch pendingType {
		case .event:
			configurePendingEvent()
			print("Evento")
		case .match:
			configurePendingMatchOrReserve()
			print("Partido")
		case .reserve:
			configurePendingMatchOrReserve()
			print("Reserva")
		default:
			break
		}
	}
	
	private func configurePendingEvent() {
		self.headerUIView.isHidden = true
		
		guard let pendingEvent = pendingEvent else { return debugPrint("Error Evento") }
		guard let eventImage = pendingEvent.eventImg else { return debugPrint("Error Event Image") }
		guard let imgUrl = URL(string: Constants.kStorageURL + eventImage) else { return debugPrint("Error Event URL Image") }
		guard let eventName = pendingEvent.eventName else { return debugPrint("Error Nombre de Evento") }
		
		self.eventImageView.loadImage(fromURL: imgUrl)
		self.eventNameLabel.text = eventName 
	}
	
	private func configurePendingMatchOrReserve() {
		self.eventHeaderUIView.isHidden = true
		
		guard let pendingEvent = pendingEvent else { return debugPrint("Error Evento") }
		guard let pendingBarcode = pendingEvent.qr else { return debugPrint("Error Qr") }
		
		
		self.barcodeImageView.image = AuxFunctions.generateQRCodeImage(reservationCode: pendingBarcode)
	}
	
	// MARK: Styles
	private func barcodeIVStyle() {
		barcodeImageView.frame = CGRect(x: 0, y: 0, width: 175, height: 175)
		barcodeImageView.layer.magnificationFilter = CALayerContentsFilter.nearest
	}
	
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "INFORMACION"
		
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
