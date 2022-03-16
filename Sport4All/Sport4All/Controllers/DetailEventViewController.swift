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
	
	// MARK: Outlets
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
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	
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
