//
//  AuthViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit

class AuthViewController: UIViewController {
	
	// MARK: Variables
	var userEmail: String?
	var userPassword: String?
	var message: String?
	
	// MARK: Outlets
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var rememberPasswordButton: UIButton!
	@IBOutlet weak var accessButton: UIButton!
	@IBOutlet weak var goToRegisterButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
		
		// Login Test Diego
		emailTextField.text = "diego171200@gmail.com"
		passwordTextField.text = "Prueba12345."
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	// MARK: Action Functions
	@IBAction func rememberPasswordButtonAction(_ sender: UIButton) {
		// Ir a Recuperar Contraseña
		let vc = UIStoryboard(name: "RetrievePassword", bundle: nil).instantiateViewController(withIdentifier: "RetrievePassword")
		present(vc, animated: true, completion: nil)
	}
	
	@IBAction func accessButtonAction(_ sender: UIButton) {
		userLogin()
	}
	
	@IBAction func goToRegisterButtonAction(_ sender: UIButton) {
		// Ir a Registro
		let vc = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "FirstRegister")
		present(vc, animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func userLogin() {
		let userLogin = getTextFieldValues()
		print(userLogin)
		
		if (emailTFisEmpty() && passwordTFisEmpty()) {
			NetworkingProvider.shared.login(userLogin: userLogin) { responseData, status, msg in
				let statusCode = status
				
				if let msg = msg {
					self.message = msg
				}
				
				if AuxFunctions.checkStatusCode(statusCode: statusCode) {
					if let authUserToken = responseData?.token {
						UserDefaultsProvider.shared.setUserDefaults(key: .authUserToken, value: authUserToken)
						
						let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
						self.show(vc, sender: self)
					}
				}  else {
					debugPrint("Error")
				}
				
			} failure: { error in
				print(error)
			}
		}
	}
		
	private func getTextFieldValues() -> UserLogin {
		if let email = emailTextField.text, let password = passwordTextField.text {
			userEmail = email
			userPassword = password
		}
		
		return UserLogin(email: userEmail, password: userPassword)
	}
	
	private func emailTFisEmpty() -> Bool {
		if emailTextField.text == "" {
			emailTextField.placeholderStyles(placeHolderText: Strings.emailErrorPlaceholder)
			emailTextField.bottomBorder(color: .red)
			return false
		} else {
			emailTextField.bottomBorder(color: .hardColor!)
			return true
		}
	}
	
	private func passwordTFisEmpty() -> Bool {
		if passwordTextField.text == ""{
			passwordTextField.placeholderStyles(placeHolderText: Strings.passwordErrorPlaceholder)
			passwordTextField.bottomBorder(color: .red)
			return false
		} else {
			passwordTextField.bottomBorder(color: .hardColor!)
			return true
		}
	}
	
	// MARK: Styles
	private func setTextFieldStyles() {
		// Estilos Email Text Field
		emailTextField.bottomBorder(color: .hardColor ?? .black)
		emailTextField.placeholderStyles(placeHolderText: Strings.emailPlaceholder)
		emailTextField.textStyles(keyboardType: .emailAddress)
		
		// Estilos Password Text Field
		passwordTextField.bottomBorder(color: .hardColor ?? .black)
		passwordTextField.placeholderStyles(placeHolderText: Strings.passwordPlaceholder)
		passwordTextField.textStyles(keyboardType: .default)
		passwordTextField.isSecureTextEntry = true
		passwordTextField.showAndHidePassword()
	}
	
	private func setButtonStyles() {
		// Estilos Access Button
		accessButton.round()
		accessButton.colors()
		accessButton.titleLabel?.font = UIFont(name: FontType.SFProDisplayBold.rawValue, size: 17)
	}
}
