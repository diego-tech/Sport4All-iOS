//
//  SecondRegisterViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 27/1/22.
//

import UIKit
import Alamofire

class SecondRegisterViewController: UIViewController, UINavigationControllerDelegate {
	
	// Variables
	var registerUserEmail: String = ""
	var registerUserPassoword: String = ""
	
	var userName: String = ""
	var userSurname: String = ""
	var userGenre: String = ""
	var imageUrl: String = ""
	
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
		registerApi()
		print(interfaceSegmented.selectedIndex)
	}
	
	@IBAction func uploadImage(_ sender: UIButton) {
		let pickerController = UIImagePickerController()
		pickerController.delegate = self
		present(pickerController, animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func uploadImage() {
		let url = "\(Constants.kBaseURL)/getUploadImage"
		
		let fileURL = Bundle.main.url(forResource: "image", withExtension: "jpg")
		
		AF.upload(fileURL!, to: url).responseDecodable(of: Response.self) { response in
			debugPrint(response)
		}
	}
	
	private func getValues() -> NewUser {
		if nameTF.text != "" {
			userName = nameTF.text!
		}
		
		if surnamesTF.text != "" {
			userSurname = surnamesTF.text!
		}
		
		return NewUser(email: registerUserEmail, password: registerUserPassoword, genre: "Hombre", name: userName, surname: userSurname, image: imageUrl)
	}
	
	private func registerApi() {
		let newUser = getValues()
		
		NetworkingProvider.shared.register(newUser: newUser) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
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


extension SecondRegisterViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true, completion: nil)
		
		let image = info[.imageURL] as! URL
		
		NetworkingProvider.shared.uploadImage(userImage: image) { responseData, status, msg in
			debugPrint(responseData)
			debugPrint(status)
			
			if let msg = msg {
				self.imageUrl = msg
			}
		} failure: { error in
			debugPrint(error)
		}
	}
}
