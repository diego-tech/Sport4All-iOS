//
//  ViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit

class ViewController: UIViewController {
	
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
	}
	
	// MARK: Functions
	private func checkTextFields() {
		if emailTextField.text == "" || passwordTextField.text == ""  {
			textFieldErrorStyles(textField: emailTextField, placeHolderText: "Introduzca el Correo Electrónico")
			textFieldErrorStyles(textField: passwordTextField, placeHolderText: "Introduzca la Contraseña")
		} else {
			debugPrint("Continua!!")
		}
	}
	
	// MARK: Styles
	private func textFieldErrorStyles(textField: UITextField, placeHolderText: String){
		textField.layer.borderColor = UIColor.redColor?.cgColor
		textField.layer.borderWidth = 1
		textField.placeholder = placeHolderText
		textField.layer.cornerCurve = .circular
		textField.layer.cornerRadius = 5
	}
	
	// MARK: Action Functions
	@IBAction func rememberPasswordButtonAction(_ sender: UIButton) {
	}
	
	@IBAction func accessButtonAction(_ sender: UIButton) {
		checkTextFields()
	}
	
	@IBAction func goToRegisterButtonAction(_ sender: Any) {
//		Ir a Registro
//		let storyBoard = UIStoryboard(name: "Register", bundle: nil)
//		let vc = storyBoard.instantiateViewController(withIdentifier: "Register")
//		present(vc, animated: true, completion: nil)
	}
}
