//
//  SecondRegisterViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 27/1/22.
//

import UIKit

class SecondRegisterViewController: UIViewController {
	
	// Variables
	
	// Outlets
	@IBOutlet weak var plusRoundedButton: UIButton!
	@IBOutlet weak var avatarButton: UIButton!
	@IBOutlet weak var nameTF: UITextField!
	@IBOutlet weak var surnamesTF: UITextField!
	@IBOutlet weak var registerButton: UIButton!
	@IBOutlet weak var interfaceSegmented: CustomSegmentedControl! {
		didSet {
			interfaceSegmented.setButtonTitles(buttonTitles: ["Mujer", "Hombre", "Otro"])
			interfaceSegmented.selectorViewColor = .hardColor!
			interfaceSegmented.selectorTextColor = .hardColor!
			interfaceSegmented.backgroundColor = .clear
		}
	}
	
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
	
	@IBAction func registerButtonAction(_ sender: UIButton) {
		print(interfaceSegmented.selectedIndex)
	}
	
	// MARK: Functions
	
	// MARK: Styles
	private func setTextFieldStyles() {
		// Estilos Name Text Field
		nameTF.bottomBorder(color: .hardColor!)
		nameTF.placeholderStyles(placeHolderText: "Nombre")
		nameTF.textStyles(keyboardType: .default)
		
		// Estilos Surnames Text Field
		surnamesTF.bottomBorder(color: .hardColor!)
		surnamesTF.placeholderStyles(placeHolderText: "Apellidos")
		surnamesTF.textStyles(keyboardType: .default)
	}
	
	private func setButtonStyles() {
		// Estilos Register Button
		registerButton.round()
		registerButton.colors()
	}
}
