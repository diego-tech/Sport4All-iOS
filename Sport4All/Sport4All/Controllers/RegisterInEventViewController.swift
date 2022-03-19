//
//  RegisterInEventViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import UIKit
import SPIndicator

class RegisterInEventViewController: UIViewController {
	
	// MARK: Variables
	var eventId: Int = 0
	
	// MARK: Outlets
	@IBOutlet weak var inscriptionButton: UIButton!
	@IBOutlet weak var userNameTextField: UITextField!
	@IBOutlet weak var userDNITextField: UITextField!
	@IBOutlet weak var userEmailTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Init Styles
		inscriptionButtonStyles()
		setTextFieldStyles()
	}
	
	override func updateViewConstraints() {
		let height: CGFloat = 400
		self.view.frame.size.height = height
		self.view.frame.origin.y = UIScreen.main.bounds.height - height
		
		self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
		
		super.updateViewConstraints()
	}
	
	// MARK: Action Functions
	@IBAction func inscriptionButtonAction(_ sender: UIButton) {
		NetworkingProvider.shared.joinEvent(event_id: eventId) { responseData, status, msg in
			guard let status = status else { return }
			guard let msg = msg else { return }
			
			if status == 1 {
				let indicatorView = SPIndicatorView(title: "Registro Realizado Correctamente", message: msg, preset: .done)
				indicatorView.present(duration: 3)
				self.dismiss(animated: true, completion: nil)
			} else {
				self.dismiss(animated: true)
				let indicatorView = SPIndicatorView(title: "Error", message: msg, preset: .error)
				indicatorView.present(duration: 3)
			}
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: Functions
	
	// MARK: Styles
	private func setTextFieldStyles() {
		// Estilos Name TextField
		userNameTextField.bottomBorder(color: .hardColor ?? .black)
		userNameTextField.placeholderStyles(placeHolderText: "Nombre")
		userNameTextField.textStyles(keyboardType: .default)
		
		// Estilos DNI TextField
		userDNITextField.bottomBorder(color: .hardColor ?? .black)
		userDNITextField.placeholderStyles(placeHolderText: "DNI")
		userDNITextField.textStyles(keyboardType: .default)
		
		// Estilos Email TextField
		userEmailTextField.bottomBorder(color: .hardColor ?? .black)
		userEmailTextField.placeholderStyles(placeHolderText: "Correo Electrónico")
		userEmailTextField.textStyles(keyboardType: .emailAddress)
	}
	
	private func inscriptionButtonStyles() {
		inscriptionButton.round()
	}
}
