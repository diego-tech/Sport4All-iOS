//
//  QRDetailViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 18/3/22.
//

import UIKit

class QRDetailViewController: UIViewController {
	
	// MARK: Variables
	var qrCode: String = ""
	
	// MARK: Outlets
	@IBOutlet weak var barcodeImageView: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Inicialización de Estilos
		view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
		styles()
		
		// Load QR
		self.barcodeImageView.image = AuxFunctions.generateQRCodeImage(reservationCode: qrCode)
    }
	
	// MARK: Styles
	private func styles() {
		// Image View Styles
		barcodeImageView.layer.magnificationFilter = CALayerContentsFilter.nearest
	}
}
