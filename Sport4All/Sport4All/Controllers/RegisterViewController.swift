//
//  RegisterViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 27/1/22.
//

import UIKit

class RegisterViewController: UIViewController {
	
	// MARK: Variables
	var registerUserEmail: String?
	var registerUserPassword: String?
	
	// MARK: Outlets
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
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	// MARK: Action Functions
	@IBAction func nextButtonAction(_ sender: UIButton) {
		if !firstEmailTF.checkIfIsEmpty(placeHolderText: Strings.emailErrorPlaceholder) && !secondEmailTF.checkIfIsEmpty(placeHolderText: Strings.emailErrorPlaceholder) && !firstPasswordTF.checkIfIsEmpty(placeHolderText: Strings.passwordErrorPlaceholder) && !secondPasswordTF.checkIfIsEmpty(placeHolderText: Strings.emailErrorPlaceholder) {
			if (checkIfEmailIsSame() && checkIfPassIsSame()) {
				registerApi()
			}
		}
	}
	
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func getTFValues() -> NewUser {
		if let email = secondEmailTF.text, let password = secondPasswordTF.text {
			registerUserEmail = email
			registerUserPassword = password
		}
		
		return NewUser(email: registerUserEmail, password: registerUserPassword, genre: nil, name: nil, surname: nil, image: nil)
	}
	
	private func registerApi() {
		let newUser = getTFValues()

		NetworkingProvider.shared.register(newUser: newUser) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
			
			let statusCode = status
		
			if AuxFunctions.checkStatusCode(statusCode: statusCode) {
				self.navigateToAuthController()
			}
		} failure: { error in
			print(error)
		}
	}
	
	private func navigateToAuthController() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
		present(vc, animated: true, completion: nil)
	}
	
	private func checkIfEmailIsSame() -> Bool{
		if firstEmailTF.text == secondEmailTF.text {
			return true
		} else {
			secondEmailTF.text = ""
			secondEmailTF.placeholderStyles(placeHolderText: Strings.notSameEmailError)
			secondEmailTF.bottomBorder(color: .red)
			return false
		}
	}
	
	private func checkIfPassIsSame() -> Bool {
		if firstPasswordTF.text == secondPasswordTF.text {
			return true
		} else {
			secondPasswordTF.text = ""
			secondPasswordTF.placeholderStyles(placeHolderText: Strings.notSamePasswordError)
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
		firstEmailTF.placeholderStyles(placeHolderText: Strings.emailPlaceholder)
		firstEmailTF.textStyles(keyboardType: .emailAddress)
		
		secondEmailTF.bottomBorder(color: .hardColor ?? .black)
		secondEmailTF.placeholderStyles(placeHolderText: Strings.confirmEmailPlaceholder)
		secondEmailTF.textStyles(keyboardType: .emailAddress)
		
		// Estilos Password Text Field
		firstPasswordTF.bottomBorder(color: .hardColor ?? .black)
		firstPasswordTF.placeholderStyles(placeHolderText: Strings.passwordPlaceholder)
		firstPasswordTF.textStyles(keyboardType: .default)
		firstPasswordTF.isSecureTextEntry = true
		firstPasswordTF.showAndHidePassword()
		
		secondPasswordTF.bottomBorder(color: .hardColor ?? .black)
		secondPasswordTF.placeholderStyles(placeHolderText: Strings.confirmPasswordPlaceholder)
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