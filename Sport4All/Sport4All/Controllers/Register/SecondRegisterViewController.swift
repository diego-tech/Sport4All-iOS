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
	
	private var userName: String?
	private var userSurname: String?
	private var userGenre: String?
	private var imageUrl: String?
	
	private var segmentedSetUp = false
	
	let pickerController = UIImagePickerController()
	
	// Outlets
	@IBOutlet weak var avatarImageView: UIImageView!
	@IBOutlet weak var nameTF: UITextField!
	@IBOutlet weak var surnamesTF: UITextField!
	@IBOutlet weak var registerButton: UIButton!
	@IBOutlet weak var genreSegmentedControl: UISegmentedControl!
	
	// MARK: Frame Cycle Functions
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Init Image Picker Delegate
		pickerController.delegate = self
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
		
		// Selector Image Init
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		avatarImageView.isUserInteractionEnabled = true
		avatarImageView.addGestureRecognizer(tapGestureRecognizer)
		avatarImageView.makeRounds()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		if segmentedSetUp == false {
			// Segmented Control
			genreSegmentedControl.setUpView()
			segmentedSetUp = true
		}
	}
	
	
	// MARK: Action Functions
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func registerButtonAction(_ sender: UIButton) {
		registerApi()
	}
	
	@IBAction func genreSegmentedControl(_ sender: UISegmentedControl) {
		genreSegmentedControl.changeUnderlinePosition() 
	}
	
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
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

		if genreSegmentedControl.selectedSegmentIndex == 0 {
			userGenre = "Mujer"
		} else if genreSegmentedControl.selectedSegmentIndex == 1 {
			userGenre = "Hombre"
		} else if genreSegmentedControl.selectedSegmentIndex == 2 {
			userGenre = "Otro"
		}

		return NewUser(email: registerUserEmail, password: registerUserPassoword, genre: userGenre, name: userName, surname: userSurname, image: imageUrl)
	}
	
	private func registerApi() {
		let newUser = getValues()
		
		NetworkingProvider.shared.register(newUser: newUser) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
			
			let statusCode = status
		
			if AuxFunctions.checkStatusCode(statusCode: statusCode) {
				self.navigateToAuthController()
			}
		} failure: { error in
			print(error)
		}
	}
	
	private func navigateToAuthController() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
		present(vc, animated: true, completion: nil)
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

//		Setear Imagen Seleccionada en el Botón

//		guard let takeImage = info[.imageURL] as? UIImage else { return }
//		self.avatarImageView?.image = image
	}
}
