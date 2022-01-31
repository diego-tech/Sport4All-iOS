//
//  AuthViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit

class AuthViewController: UIViewController {
	
	// Variables
	
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
		clubList()
	}
	
	// MARK: Action Functions
	@IBAction func rememberPasswordButtonAction(_ sender: UIButton) {
		// Ir a Recuperar Contraseña
		let storyBoard = UIStoryboard(name: "RetrievePassword", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "RetrievePassword")
		present(vc, animated: true, completion: nil)
	}
	
	@IBAction func accessButtonAction(_ sender: UIButton) {
		checkTextFields()
	}
	
	@IBAction func goToRegisterButtonAction(_ sender: UIButton) {
		// Ir a Registro
		let storyBoard = UIStoryboard(name: "Register", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "FirstRegister")
		present(vc, animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func checkTextFields() {
		if emailTextField.text == "" || passwordTextField.text == ""  {
			emailTextField.placeholderStyles(placeHolderText: "Introduzca el Correo Electrónico")
			emailTextField.bottomBorder(color: .red)
			passwordTextField.placeholderStyles(placeHolderText: "Introduzca la Contraseña")
			passwordTextField.bottomBorder(color: .red)
		} else {
			debugPrint("Continua!!")
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
	private func register() {
		let newUser = NewUser(email: "test1@test.com", password: "Test12345.", genre: "Otro", name: "Test", surname: "Test 1", image: "test.png")
		
		NetworkingProvider.shared.register(newUser: newUser) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func login() {
		let userLogin = UserLogin(email: "test1@test.com", password: "s0fBYfoZ")
		
		NetworkingProvider.shared.login(userLogin: userLogin) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func userInfo() {
		NetworkingProvider.shared.userInfo { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func retrievePassword() {
		let userEmail = "test1@test.com"
		
		NetworkingProvider.shared.retrievePassword(email: userEmail) { status, msg in
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func modifyData() {
		let modifyUser = NewUser(email: nil, password: nil, genre: nil, name: "Test Modificado", surname: nil, image: nil)
		
		NetworkingProvider.shared.modifyData(userModify: modifyUser) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func modifyPassword() {
		let password = "Pass1."
		
		NetworkingProvider.shared.modifyPassword(newPassword: password) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func registerFavClub() {
		NetworkingProvider.shared.registerFavClub(clubId: 1) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func clubList() {
		NetworkingProvider.shared.clubList { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
}
