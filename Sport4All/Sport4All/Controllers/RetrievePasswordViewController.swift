//
//  RetrievePasswordViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 28/1/22.
//

import UIKit
import SPIndicator

class RetrievePasswordViewController: UIViewController {
	
	// MARK: Variables
	var email: String?
	
	// MARK: Outlets
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var sendButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		emailTF.delegate = self
		sendButton.isEnabled = false
		sendButton.alpha = 0.5
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
	}
	
	// MARK: Action Functions
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func sendButtonAction(_ sender: UIButton) {
		checkTextField()
	}
	
	// MARK: Functions
	private func checkTextField() {
		if emailTF.text == "" {
			emailTF.placeholderStyles(placeHolderText: Strings.emailErrorPlaceholder)
			emailTF.bottomBorder(color: .red)
		} else {
			if let email = emailTF.text {
				self.email = email
			}
			
			self.retrievePassword()
		}
	}
	
	private func retrievePassword() {
		guard let email = email else { return }
		
		NetworkingProvider.shared.retrievePassword(email: email) { status, msg in
			if status == 1 {
				let indicator = SPIndicatorView(title: "Compruebe su bandeja de entrada", preset: .done)
				indicator.present(duration: 2) {
					self.goToAuth()
				}
			} else {
				let indicator = SPIndicatorView(title: "Ha Ocurrido un Error", message: "Pruebe más tarde", preset: .error)
				indicator.present(duration: 3)
			}
		} failure: { error in
			debugPrint(error?.localizedDescription)
			self.goToAuth()
		}
	}
	
	private func goToAuth() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
		vc.modalPresentationStyle = .fullScreen
		vc.modalTransitionStyle = .coverVertical
		self.present(vc, animated: true, completion: nil)
	}
	
	// MARK: Styles
	private func setTextFieldStyles() {
		// Estilos Email Text Field
		emailTF.bottomBorder(color: .hardColor ?? .black)
		emailTF.placeholderStyles(placeHolderText: Strings.emailPlaceholder)
		emailTF.textStyles(keyboardType: .emailAddress)
	}
	
	private func setButtonStyles() {
		// Estilos Send Button
		sendButton.round()
		sendButton.colors()
	}
}

// MARK: UITextField Delegate
extension RetrievePasswordViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

		if text.isEmpty {
			UIView.animate(withDuration: 1) {
				self.sendButton.isEnabled = false
				self.sendButton.alpha = 0.5
			}
		} else {
			UIView.animate(withDuration: 1) {
				self.sendButton.isEnabled = true
				self.sendButton.alpha = 1
			}
		}
		
		return true
	}
}
