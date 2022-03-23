//
//  AuthViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit
import SPIndicator

enum ErrorType {
	case decodingError
	case userTokenError
}

class AuthViewController: UIViewController {
	
	// MARK: Variables
	var userEmail: String?
	var userPassword: String?
	var message: String?
	
	var errorType: ErrorType?
	
	// MARK: Outlets
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var rememberPasswordButton: UIButton!
	@IBOutlet weak var accessButton: UIButton!
	@IBOutlet weak var goToRegisterButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Set Up Errors
		setIndicatorForErrors()
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
		
		// Login Test Diego
		emailTextField.text = "diego171200@gmail.com"
		passwordTextField.text = "Prueba12345."
		
		// TextField Delegates
		emailTextField.delegate = self
		passwordTextField.delegate = self
		accessButton.isEnabled = false
		accessButton.alpha = 0.5
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
				
				guard let msg = msg else { return }
				guard let errorMsg = responseData?.errors else { return }
				
				if AuxFunctions.checkStatusCode(statusCode: statusCode) {
					if let authUserToken = responseData?.token, let authUserEmail = responseData?.email {
						if let authUserName = responseData?.name {
							UserDefaultsProvider.shared.setUserDefaults(key: .authUserName, value: authUserName)
						}
						
						if let authUserSurname = responseData?.surname {
							UserDefaultsProvider.shared.setUserDefaults(key: .authUserSurname, value: authUserSurname)
						}
						
						if let authUserImg = responseData?.image {
							UserDefaultsProvider.shared.setUserDefaults(key: .authUserImg, value: authUserImg)
						}
						
						if let authUserGenre = responseData?.genre {
							UserDefaultsProvider.shared.setUserDefaults(key: .authUserGenre, value: authUserGenre)
						}
						
						UserDefaultsProvider.shared.setUserDefaults(key: .authUserToken, value: authUserToken)
						UserDefaultsProvider.shared.setUserDefaults(key: .authUserEmail, value: authUserEmail)
						
						guard let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as? TabBarController else {
							fatalError("Can't load tabbars")
						}
						(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
					}
				}  else {
					let indicator = SPIndicatorView(title: msg, message: errorMsg, preset: .error)
					indicator.present(duration: 2)
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
	
	private func setIndicatorForErrors() {
		switch errorType {
		case .decodingError:
			print("Error 2")
			let indicatorView = SPIndicatorView(title: "Error", message: "Pruebe a logearse otra vez", preset: .error)
			indicatorView.present(duration: 3)
		case .userTokenError:
			print("Error 3")
		default:
			break
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

// MARK: UITextField Delegate
extension AuthViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

		if text.isEmpty {
			UIView.animate(withDuration: 1) {
				self.accessButton.isEnabled = false
				self.accessButton.alpha = 0.5
			}
		} else {
			UIView.animate(withDuration: 1) {
				self.accessButton.isEnabled = true
				self.accessButton.alpha = 1
			}
		}
	
		return true
	}
}

