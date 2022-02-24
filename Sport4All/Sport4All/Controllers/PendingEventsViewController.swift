//
//  PendingEventsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class PendingEventsViewController: UIViewController {
	
	// Variables
	
	// Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var barcodeIV: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Inicialización de Estilos
		headerUIView.bottomShadow()
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	
	// MARK: Styles
}
