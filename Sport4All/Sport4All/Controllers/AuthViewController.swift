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
	}
	
	// MARK: Action Functions
	@IBAction func rememberPasswordButtonAction(_ sender: UIButton) {
	}
	
	@IBAction func accessButtonAction(_ sender: UIButton) {
		checkTextFields()
	}
	
	@IBAction func goToRegisterButtonAction(_ sender: UIButton) {
//		Ir a Registro
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
}
