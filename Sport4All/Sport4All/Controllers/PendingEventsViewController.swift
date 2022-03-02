//
//  PendingEventsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class PendingEventsViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var barcodeIV: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización de Estilos
		headerUIView.bottomShadow()
		barcodeIVStyle()
		
		// Generado de QR Prueba
		testQRCodeGen()
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func testQRCodeGen() {
		barcodeIV.image = GenQRCode.generateQRCodeImage(reservationCode: "test")
	}
	
	// MARK: Styles
	private func barcodeIVStyle() {
		barcodeIV.frame = CGRect(x: 0, y: 0, width: 175, height: 175)
		barcodeIV.layer.magnificationFilter = CALayerContentsFilter.nearest
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
