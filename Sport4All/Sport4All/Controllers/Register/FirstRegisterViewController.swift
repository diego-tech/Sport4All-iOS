//
//  FirstRegisterViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 27/1/22.
//

import UIKit

struct FirstRegisterDataModel: Encodable {
	let email: String?
	let password: String?
}

class FirstRegisterViewController: UIViewController {
	
	// Variables
	var registerUserEmail: String?
	var registerUserPassword: String?
	
	// Outlets
	@IBOutlet weak var firstEmailTF: UITextField!
	@IBOutlet weak var secondEmailTF: UITextField!
	@IBOutlet weak var firstPasswordTF: UITextField!
	@IBOutlet weak var secondPasswordTF: UITextField!
	@IBOutlet weak var nextButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
		
		// Register Test Diego
		firstEmailTF.text = "prueba3@prueba.com"
		secondEmailTF.text = "prueba3@prueba.com"
		firstPasswordTF.text = "Prueba12345."
		secondPasswordTF.text = "Prueba12345."
	}
	
	// MARK: Action Functions
	@IBAction func nextButtonAction(_ sender: UIButton) {
		if !firstEmailTF.checkIfIsEmpty(placeHolderText: "Introduzca el Correo Electrónico") && !secondEmailTF.checkIfIsEmpty(placeHolderText: "Introduzca el Correo Electrónico") && !firstPasswordTF.checkIfIsEmpty(placeHolderText: "Introduzca la Contraseña") && !secondPasswordTF.checkIfIsEmpty(placeHolderText: "Introduzca la Contraseña") {
			if (checkIfEmailIsSame() && checkIfPassIsSame()) {
				checkUserExists()
			}
		}
	}
	
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func getTFValues() -> FirstRegisterDataModel{		
		if let email = secondEmailTF.text, let password = secondPasswordTF.text {
			registerUserEmail = email
			registerUserPassword = password
		}
		
		return FirstRegisterDataModel(email: registerUserEmail, password: registerUserPassword)
	}
	
	private func checkUserExists() {
		let firstRegisterData = getTFValues()
		
		NetworkingProvider.shared.checkUserExists(firstRegisterData: firstRegisterData) { responseData, status, msg in
			let statusCode = status
			
			if AuxFunctions.checkStatusCode(statusCode: statusCode) {
				self.navigateToSecondRegister()
			} else {
				let response = responseData
				debugPrint(response)
				
				let message = msg
				self.alertFunction(title: "Error", msg: message!)
			}
		} failure: { error in
			let err = error
			debugPrint(err)
		}
	}
	
	private func navigateToSecondRegister() {
		let vc = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "SecondRegister") as! SecondRegisterViewController
		
		if firstEmailTF.text != "" {
			vc.registerUserEmail = firstEmailTF.text!
		}
		
		if firstPasswordTF.text != "" {
			vc.registerUserPassoword = firstPasswordTF.text!
		}
		
		present(vc, animated: true, completion: nil)
	}
	
	private func checkIfEmailIsSame() -> Bool{
		if firstEmailTF.text == secondEmailTF.text {
			return true
		} else {
			secondEmailTF.text = ""
			secondEmailTF.placeholderStyles(placeHolderText: "El Correo Electrónico No Coincide")
			secondEmailTF.bottomBorder(color: .red)
			return false
		}
	}
	
	private func checkIfPassIsSame() -> Bool {
		if firstPasswordTF.text == secondPasswordTF.text {
			return true
		} else {
			secondPasswordTF.text = ""
			secondPasswordTF.placeholderStyles(placeHolderText: "Las Contraseñas No Coinciden")
			secondPasswordTF.bottomBorder(color: .red)
			return false
		}
	}
	
	private func alertFunction(title: String, msg: String){
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Volver", style: .default, handler: { action in
			self.dismiss(animated: true, completion: nil)
		}))
		
		present(alert, animated: true)
	}
	
	// MARK: Styles
	private func setTextFieldStyles() {
		// Estilos Email Text Field
		firstEmailTF.bottomBorder(color: .hardColor ?? .black)
		firstEmailTF.placeholderStyles(placeHolderText: "Correo Electrónico")
		firstEmailTF.textStyles(keyboardType: .emailAddress)
		
		secondEmailTF.bottomBorder(color: .hardColor ?? .black)
		secondEmailTF.placeholderStyles(placeHolderText: "Confirmar Correo Electróncio")
		secondEmailTF.textStyles(keyboardType: .emailAddress)
		
		// Estilos Password Text Field
		firstPasswordTF.bottomBorder(color: .hardColor ?? .black)
		firstPasswordTF.placeholderStyles(placeHolderText: "Contraseña")
		firstPasswordTF.textStyles(keyboardType: .default)
		firstPasswordTF.isSecureTextEntry = true
		firstPasswordTF.showAndHidePassword()
		
		secondPasswordTF.bottomBorder(color: .hardColor ?? .black)
		secondPasswordTF.placeholderStyles(placeHolderText: "Confirmar Contraseña")
		secondPasswordTF.textStyles(keyboardType: .default)
		secondPasswordTF.isSecureTextEntry = true
		secondPasswordTF.showAndHidePassword()
	}
	
	private func setButtonStyles() {
		// Estilos Next Button
		nextButton.round()
		nextButton.colors()
	}
}
