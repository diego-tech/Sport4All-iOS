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
}
