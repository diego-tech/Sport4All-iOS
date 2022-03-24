//
//  ModifyPasswordViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/2/22.
//

import UIKit
import SPIndicator

class ModifyPasswordViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var savePasswordBTN: UIButton!
	@IBOutlet weak var firstPasswordTF: UITextField!
	@IBOutlet weak var checkPasswordTF: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
		
		// UITextField Delegates
		firstPasswordTF.delegate = self
		checkPasswordTF.delegate = self
		
		// Configuration Password At First
		savePasswordBTN.isEnabled = false
		savePasswordBTN.alpha = 0.5
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	// MARK: Action Functions
	@IBAction func savePasswordButtonAction(_ sender: UIButton) {
		changePassword()
	}
	
	// MARK: Functions
	private func changePassword() {
		if !firstPasswordTF.checkIfIsEmpty(placeHolderText: "Introduzca la Contraseña") && !checkPasswordTF.checkIfIsEmpty(placeHolderText: "Introduzca la Contraseña") {
			if checkIfPassIsSame() {
				UIView.animate(withDuration: 1) {
					self.savePasswordBTN.isEnabled = false
					self.savePasswordBTN.alpha = 0.5
				}
				
				guard let password = checkPasswordTF.text else { return }
				
				NetworkingProvider.shared.modifyPassword(newPassword: password) { responseData, status, msg in
					guard let errorMsg = responseData?.errors else { return }
					guard let status = status else { return }
					guard let msg = msg else { return }
					
					if status == 1 {
						let indicatorView = SPIndicatorView(title: "Contraseña modificada correctamente", message: msg, preset: .done)
						indicatorView.present(duration: 3) {
							let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
							vc.modalPresentationStyle = .automatic
							vc.modalTransitionStyle = .coverVertical
							self.navigationController?.pushViewController(vc, animated: true)
						}
					} else {
						let indicatorView = SPIndicatorView(title: "Ha ocurrido un error", message: errorMsg, preset: .error)
						indicatorView.present(duration: 3)
					}
					
					UIView.animate(withDuration: 1) {
						self.savePasswordBTN.isEnabled = true
						self.savePasswordBTN.alpha = 1
					}
				} failure: { error in
					let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
					vc.modalPresentationStyle = .fullScreen
					vc.modalTransitionStyle = .coverVertical
					vc.errorType = .decodingError
					self.present(vc, animated: true, completion: nil)
				}
			}
		}
	}
	
	private func checkIfPassIsSame() -> Bool {
		if firstPasswordTF.text == checkPasswordTF.text {
			return true
		} else {
			checkPasswordTF.text = ""
			checkPasswordTF.placeholderStyles(placeHolderText: "Las Contraseñas No Coinciden")
			checkPasswordTF.bottomBorder(color: .red)
			return false
		}
	}
	
	// MARK: Styles
	private func setTextFieldStyles() {
		// Estilos First Password Text Field
		firstPasswordTF.bottomBorder(color: .hardColor ?? .black)
		firstPasswordTF.placeholderStyles(placeHolderText: "Contraseña")
		firstPasswordTF.textStyles(keyboardType: .default)
		firstPasswordTF.isSecureTextEntry = true
		firstPasswordTF.showAndHidePassword()
		
		// Estilos Check Password Text Field
		checkPasswordTF.bottomBorder(color: .hardColor ?? .black)
		checkPasswordTF.placeholderStyles(placeHolderText: "Confirmar Contraseña")
		checkPasswordTF.textStyles(keyboardType: .default)
		checkPasswordTF.isSecureTextEntry = true
		checkPasswordTF.showAndHidePassword()
	}
	
	private func setButtonStyles() {
		// Estilos Save Password Button
		savePasswordBTN.round()
		savePasswordBTN.colors()
	}
	
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "CAMBIAR CONTRASEÑA"
		
		let yourBackImage = UIImage(systemName: "arrowshape.turn.up.backward.fill", withConfiguration:  UIImage.SymbolConfiguration(pointSize: 18))
		let backButtonItem = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(popView(tapGestureRecognizer:)))
		backButtonItem.tintColor = .corporativeColor
		
		self.navigationItem.leftBarButtonItem = backButtonItem
		
		self.navigationItem.setHidesBackButton(true, animated: true)
	}
	
	@objc func popView(tapGestureRecognizer: UITapGestureRecognizer) {
		self.navigationController?.popViewController(animated: true)
	}
}

// MARK: UITextField Delegate
extension ModifyPasswordViewController: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

		if text.isEmpty {
			UIView.animate(withDuration: 1) {
				self.savePasswordBTN.isEnabled = false
				self.savePasswordBTN.alpha = 0.5
			}
		} else {
			UIView.animate(withDuration: 1) {
				self.savePasswordBTN.isEnabled = true
				self.savePasswordBTN.alpha = 1
			}
		}
	
		return true
	}
}
