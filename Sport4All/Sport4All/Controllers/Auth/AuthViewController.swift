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
		emailTextField.bottomBorder(color: .hardColor ?? .black)
		emailTextField.placeholderStyles(placeHolderText: "Correo Electrónico")
		emailTextField.textStyles(keyboardType: .emailAddress)
		
		// Estilos Password Text Field
		passwordTextField.bottomBorder(color: .hardColor ?? .black)
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
//	private func clubList() {
//		NetworkingProvider.shared.clubList { responseData, status, msg in
//			print(responseData)
//			print(status)
//			print(msg)
//		} failure: { error in
//			print(error)
//		}
//	}
}
