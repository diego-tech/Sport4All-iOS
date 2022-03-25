//
//  AuthViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit
import SPIndicator
import Alamofire

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
		
		// Check if user has internet
		checkIfHasInternet()
		
		// Set Up Errors
		setIndicatorForErrors()
		
		// Styles Inicialization
		setTextFieldStyles()
		setButtonStyles()
		
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
		// Go to Recovery Password
		let vc = UIStoryboard(name: "RetrievePassword", bundle: nil).instantiateViewController(withIdentifier: "RetrievePassword")
		present(vc, animated: true, completion: nil)
	}
	
	@IBAction func accessButtonAction(_ sender: UIButton) {
		fetchUserLogin()
	}
	
	@IBAction func goToRegisterButtonAction(_ sender: UIButton) {
		// Go To Register Screen
		let vc = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "FirstRegister")
		present(vc, animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func fetchUserLogin() {
		let userLogin = getTextFieldValues()
		
		if (emailTFisEmpty() && passwordTFisEmpty()) {
			NetworkingProvider.shared.login(userLogin: userLogin) { responseData, status, msg in
				let statusCode = status
				
				guard let msg = msg else { return }
				guard let errorMsg = responseData?.errors else { return }
				
				if AuxFunctions.checkStatusCode(statusCode: statusCode) {
					if let authUserToken = responseData?.token, let authUserEmail = responseData?.email {
						UserDefaultsProvider.shared.setUserDefaults(key: .authUserToken, value: authUserToken)
						UserDefaultsProvider.shared.setUserDefaults(key: .authUserEmail, value: authUserEmail)
						
						self.goToHome()
					}
				}  else {
					let indicator = SPIndicatorView(title: msg, message: errorMsg, preset: .error)
					indicator.present(duration: 2)
				}
			} failure: { error in
				guard let error = error else { return }
				debugPrint("Auth VC Fatal Error \(error)")
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
			let alertView = UIAlertController(title: "Error", message: "Pruebe a logearse otra vez", preferredStyle: .alert)
			present(alertView, animated: true)
		case .userTokenError:
			debugPrint("User Token Error")
		default:
			break
		}
	}
	
	private func goToHome() {
		guard let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as? TabBarController else {
			fatalError("Can't load tabbars")
		}
		
		let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
		sceneDelegate?.changeRootViewController(vc)
	}
	
	private func checkIfHasInternet() {
		let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")

		reachabilityManager?.startListening { status in
			switch status {
			case .notReachable:
				debugPrint("No Internet")
				let indicatorView = SPIndicatorView(title: "No Tienes Conexión a Internet", preset: .error)
				indicatorView.present(duration: 3)
				self.accessButton.isEnabled = true
				self.accessButton.alpha = 0.5
			case .unknown:
				debugPrint("Unknown")
				let indicatorView = SPIndicatorView(title: "No Tienes Conexión a Internet", preset: .error)
				indicatorView.present(duration: 3)
				self.accessButton.isEnabled = true
				self.accessButton.alpha = 0.5
			case .reachable(.cellular):
				debugPrint("Cellular")
			case .reachable(.ethernetOrWiFi):
				debugPrint("Wifi")
			}
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

