//
//  InfoClubViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 15/2/22.
//

import UIKit

class InfoClubViewController: UIViewController {

	// Variables
	
	// Outlets
	@IBOutlet weak var headerUIView: UIView?
	@IBOutlet weak var webContactBTN: UIButton?
	@IBOutlet weak var phoneContactBTN: UIButton?
	@IBOutlet weak var reservBTN: UIButton?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Inicialización Estilos
		buttonStyles()
		headerUIView?.bottomShadow()
    }

	
	// MARK: Styles
	
	private func buttonStyles() {
		// Botón Reservar
		reservBTN?.round()
	}
}
