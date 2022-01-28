//
//  FirstRegisterViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 27/1/22.
//

import UIKit

class FirstRegisterViewController: UIViewController {

	// Variables
	
	// Outlets
	@IBOutlet weak var firstEmailTF: UITextField!
	@IBOutlet weak var secondEmailTF: UITextField!
	@IBOutlet weak var firstPasswordTF: UITextField!
	@IBOutlet weak var secondPasswordTF: UITextField!
	@IBOutlet weak var nextButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
    }
	
	// MARK: Action Functions
	@IBAction func nextButtonAction(_ sender: UIButton) {
		checkTextFields()
		
		let storyboard = UIStoryboard(name: "Register", bundle: nil)
		let vc = storyboard.instantiateViewController(withIdentifier: "SecondRegister")
		
		present(vc, animated: true, completion: nil)
	}
	
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func checkTextFields() {
		if firstEmailTF.text == "" || secondEmailTF.text == "" || firstPasswordTF.text == "" || secondPasswordTF.text == "" {
			firstEmailTF.placeholderStyles(placeHolderText: "Introduzca el Correo Electrónico")
			firstEmailTF.bottomBorder(color: .red)
			
			secondEmailTF.placeholderStyles(placeHolderText: "Introduzca el Correo Electrónico")
			secondEmailTF.bottomBorder(color: .red)
			
			firstPasswordTF.placeholderStyles(placeHolderText: "Introduzca la Contraseña")
			firstPasswordTF.bottomBorder(color: .red)
			
			secondPasswordTF.placeholderStyles(placeHolderText: "Introduza la Contraseña")
			secondPasswordTF.bottomBorder(color: .red)
		} else {
			debugPrint("Continua!!")
		}
	}
	
	// MARK: Styles
	private func setTextFieldStyles() {
		// Estilos Email Text Field
		firstEmailTF.bottomBorder(color: .hardColor!)
		firstEmailTF.placeholderStyles(placeHolderText: "Correo Electrónico")
		firstEmailTF.textStyles(keyboardType: .emailAddress)
		
		secondEmailTF.bottomBorder(color: .hardColor!)
		secondEmailTF.placeholderStyles(placeHolderText: "Confirmar Correo Electróncio")
		secondEmailTF.textStyles(keyboardType: .emailAddress)
		
		// Estilos Password Text Field
		firstPasswordTF.bottomBorder(color: .hardColor!)
		firstPasswordTF.placeholderStyles(placeHolderText: "Contraseña")
		firstPasswordTF.textStyles(keyboardType: .default)
		firstPasswordTF.isSecureTextEntry = true
		firstPasswordTF.showAndHidePassword()
		
		secondPasswordTF.bottomBorder(color: .hardColor!)
		secondPasswordTF.placeholderStyles(placeHolderText: "Confirmar Contraseña")
		secondPasswordTF.textStyles(keyboardType: .default)
		secondPasswordTF.isSecureTextEntry = true
		secondPasswordTF.showAndHidePassword()
	}
	
	private func setButtonStyles() {
		// Estilos Next Button
		nextButton.round()
		nextButton.colors()
	}
}
