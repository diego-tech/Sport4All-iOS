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
	@IBOutlet weak var webContactBTN: UIButton?
	@IBOutlet weak var phoneContactBTN: UIButton?
	@IBOutlet weak var headerUIView: UIView?
	@IBOutlet weak var reservBTN: UIButton?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Inicialización Estilos
		buttonStyles()
		viewShadow()
    }
	
	
	// MARK: Styles
	private func viewShadow() {
		headerUIView?.layer.masksToBounds = false
		headerUIView?.layer.shadowRadius = 3
		headerUIView?.layer.shadowOpacity = 0.2
		headerUIView?.layer.shadowColor = UIColor.gray.cgColor
		headerUIView?.layer.shadowOffset = CGSize(width: 0, height: 4)
		headerUIView?.layer.zPosition = 1
	}
	
	private func buttonStyles() {
		// Atributos Title del Botón
		let attributes = [
			NSAttributedString.Key.font: UIFont(name: FontType.SFProLight.rawValue, size: 15)
		]
		
		// Botón Web Contacto
		webContactBTN?.titleLabel?.attributedText = NSAttributedString(
			string: "WEB",
			attributes: attributes as [NSAttributedString.Key : Any]
		)
		webContactBTN?.titleLabel?.textColor = .blueBerry
		
		// Botón Llamar Contacto
		phoneContactBTN?.titleLabel?.attributedText = NSAttributedString(
			string: "WEB",
			attributes: attributes as [NSAttributedString.Key : Any]
		)
		phoneContactBTN?.titleLabel?.textColor = .blueBerry
		
		// Botón Reservar
		reservBTN?.round()
	}
}
