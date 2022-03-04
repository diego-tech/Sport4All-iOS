//
//  ModifyPasswordViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/2/22.
//

import UIKit

class ModifyPasswordViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var goBackBTN: UIButton!
	@IBOutlet weak var savePasswordBTN: UIButton!
	@IBOutlet weak var firstPasswordTF: UITextField!
	@IBOutlet weak var checkPasswordTF: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
    }
	
	// MARK: Action Functions
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func savePasswordButtonAction(_ sender: UIButton) {
		changePassword()
	}
	
	// MARK: Functions
	private func changePassword() {
		if !firstPasswordTF.checkIfIsEmpty(placeHolderText: "Introduzca la Contraseña") && !checkPasswordTF.checkIfIsEmpty(placeHolderText: "Introduzca la Contraseña") {
			if checkIfPassIsSame() {
				debugPrint("Contraseña Cambiada")
			}
		}
	}
	
	private func checkIfPassIsSame() -> Bool {
		if firstPasswordTF.text == checkPasswordTF.text {
			return true
		} else {
			checkPasswordTF.text = ""
			checkPasswordTF.placeholderStyles(placeHolderText: "Las Contraseñas No Coinciden")
			checkPasswordTF.bottomBorder(color: .red)
			return false
		}
	}
	
	// MARK: Styles
	private func setTextFieldStyles() {
		// Estilos First Password Text Field
		firstPasswordTF.bottomBorder(color: .hardColor ?? .black)
		firstPasswordTF.placeholderStyles(placeHolderText: "Contraseña")
		firstPasswordTF.textStyles(keyboardType: .default)
		firstPasswordTF.isSecureTextEntry = true
		firstPasswordTF.showAndHidePassword()
		
		// Estilos Check Password Text Field
		checkPasswordTF.bottomBorder(color: .hardColor ?? .black)
		checkPasswordTF.placeholderStyles(placeHolderText: "Confirmar Contraseña")
		checkPasswordTF.textStyles(keyboardType: .default)
		checkPasswordTF.isSecureTextEntry = true
		checkPasswordTF.showAndHidePassword()
	}
	
	private func setButtonStyles() {
		// Estilos Save Password Button
		savePasswordBTN.round()
		savePasswordBTN.colors()
	}
	
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "CAMBIAR CONTRASEÑA"
		
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
