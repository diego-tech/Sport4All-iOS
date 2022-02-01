//
//  AuthViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit

class AuthViewController: UIViewController {
	
	// Variables
	var userEmail: String?
	var userPassword: String?
	var message: String?
	
	// Outlets
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
		
		// Testeo Funciones API
//		register()
//		login()
//		userInfo()
//		retrievePassword()
//		modifyData()
//		modifyPassword()
//		registerFavClub()
//		clubList()
	}
	
	// MARK: Action Functions
	@IBAction func rememberPasswordButtonAction(_ sender: UIButton) {
		// Ir a Recuperar Contraseña
		let storyBoard = UIStoryboard(name: "RetrievePassword", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "RetrievePassword")
		present(vc, animated: true, completion: nil)
	}
	
	@IBAction func accessButtonAction(_ sender: UIButton) {
		userLogin()
	}
	
	@IBAction func goToRegisterButtonAction(_ sender: UIButton) {
		// Ir a Registro
		let storyBoard = UIStoryboard(name: "Register", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "FirstRegister")
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
				
				if self.checkStatusCode(statusCode: statusCode) {
					if let authUserToken = responseData?.token {
						UserDefaultsProvider.setUserDefaults(key: .authUserToken, value: authUserToken)
					}
					let storyBoard = UIStoryboard(name: "TabBar", bundle: nil)
					let vc = storyBoard.instantiateViewController(withIdentifier: "TabBar")
					self.show(vc, sender: self)
				}  else {
					debugPrint("Error")
				}
				
			} failure: { error in
				print(error)
			}
		}
	}
	
	private func checkStatusCode(statusCode: Int?) -> Bool {
		if statusCode == 0 {
			return false
		} else if (statusCode == 1) {
			return true
		} else {
			return false
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
			emailTextField.placeholderStyles(placeHolderText: "Introduzca el Correo Electrónico")
			emailTextField.bottomBorder(color: .red)
			return false
		} else {
			emailTextField.bottomBorder(color: .hardColor!)
			return true
		}
	}
	
	private func passwordTFisEmpty() -> Bool {
		if passwordTextField.text == ""{
			passwordTextField.placeholderStyles(placeHolderText: "Introduzca la Contraseña")
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
		emailTextField.bottomBorder(color: .hardColor!)
		emailTextField.placeholderStyles(placeHolderText: "Correo Electrónico")
		emailTextField.textStyles(keyboardType: .emailAddress)
		
		// Estilos Password Text Field
		passwordTextField.bottomBorder(color: .hardColor!)
		passwordTextField.placeholderStyles(placeHolderText: "Contraseña")
		passwordTextField.textStyles(keyboardType: .default)
		passwordTextField.isSecureTextEntry = true
		passwordTextField.showAndHidePassword()
	}
	
	private func setButtonStyles() {
		// Estilos Access Button
		accessButton.round()
		accessButton.colors()
	}
	
	// MARK: API FUNCTIONS TEST
//	private func register() {
//		let newUser = NewUser(email: "test1@test.com", password: "Test1234", genre: "Otro", name: "Test", surname: "Test 1", image: "test.png")
//
//		NetworkingProvider.shared.register(newUser: newUser) { responseData, status, msg in
//			print(responseData)
//			print(status)
//			print(msg)
//		} failure: { error in
//			print(error)
//		}
//	}
//
//	private func login() {
//		let userLogin = UserLogin(email: "test1@test.com", password: "s0fBYfoZ")
//
//		NetworkingProvider.shared.login(userLogin: userLogin) { responseData, status, msg in
//			print(responseData)
//			print(status)
//			print(msg)
//		} failure: { error in
//			print(error)
//		}
//	}
//
//	private func userInfo() {
//		NetworkingProvider.shared.userInfo { responseData, status, msg in
//			print(responseData)
//			print(status)
//			print(msg)
//		} failure: { error in
//			print(error)
//		}
//	}
//
//	private func retrievePassword() {
//		let userEmail = "test1@test.com"
//
//		NetworkingProvider.shared.retrievePassword(email: userEmail) { status, msg in
//			print(status)
//			print(msg)
//		} failure: { error in
//			print(error)
//		}
//	}
//
//	private func modifyData() {
//		let modifyUser = NewUser(email: nil, password: nil, genre: nil, name: "Test Modificado", surname: nil, image: nil)
//
//		NetworkingProvider.shared.modifyData(userModify: modifyUser) { responseData, status, msg in
//			print(responseData)
//			print(status)
//			print(msg)
//		} failure: { error in
//			print(error)
//		}
//	}
//
//	private func modifyPassword() {
//		let password = "Pass1."
//
//		NetworkingProvider.shared.modifyPassword(newPassword: password) { responseData, status, msg in
//			print(responseData)
//			print(status)
//			print(msg)
//		} failure: { error in
//			print(error)
//		}
//	}
//
//	private func registerFavClub() {
//		NetworkingProvider.shared.registerFavClub(clubId: 1) { responseData, status, msg in
//			print(responseData)
//			print(status)
//			print(msg)
//		} failure: { error in
//			print(error)
//		}
//	}
//
//		private func clubList() {
//			NetworkingProvider.shared.clubList { responseData, status, msg in
//				print(responseData)
//				print(status)
//				print(msg)
//			} failure: { error in
//				print(error)
//			}
//		}
}
