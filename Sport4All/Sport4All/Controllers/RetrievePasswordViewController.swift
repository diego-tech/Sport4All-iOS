//
//  RetrievePasswordViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 28/1/22.
//

import UIKit

class RetrievePasswordViewController: UIViewController {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var emailTF: UITextField!
	@IBOutlet weak var sendButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
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
			debugPrint("Continua!!")
		}
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
