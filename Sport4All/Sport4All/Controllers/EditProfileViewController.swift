//
//  EditProfileViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import UIKit
import SPIndicator

class EditProfileViewController: UIViewController, UINavigationControllerDelegate {
	
	// MARK: Variables
	private var userName: String?
	private var userSurname: String?
	private var userGenre: String?
	private var imageUrl: String?
	private var userEmail: String?
	
	let pickerController = UIImagePickerController()
	
	// MARK: Outles
	@IBOutlet weak var userImageView: LazyImageView!
	@IBOutlet weak var userNameTF: UITextField!
	@IBOutlet weak var userSurnameTF: UITextField!
	@IBOutlet weak var userEmailTF: UITextField!
	@IBOutlet weak var goToChangePasswordBTN: UIButton!
	@IBOutlet weak var genreSegmentedControl: CustomSegmentedControl!
	@IBOutlet weak var editButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Inicialización Estilos
		setTextFieldStyles()
		setButtonStyles()
		setImageStyles()
		setSegmentedControl()
		
		// Init Image Picker Delegate
		pickerController.delegate = self
		
		// Configure Navbar
		configureNavbar()
		
		// Selector Image Init
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		userImageView.isUserInteractionEnabled = true
		userImageView.addGestureRecognizer(tapGestureRecognizer)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		// Segmented Control
		genreSegmentedControl.setUpView()
	}
	
	// MARK: Action Functions
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		present(pickerController, animated: true, completion: nil)
	}
	
	@IBAction func genreSegmentedControl(_ sender: UISegmentedControl) {
		genreSegmentedControl.changeUnderlinePosition()
	}
	
	@IBAction func goToChangePasswordButtonAction(_ sender: UIButton) {
		let vc = UIStoryboard(name: "ModifyPassword", bundle: nil).instantiateViewController(withIdentifier: "ModifyPassword") as! ModifyPasswordViewController
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction func editButtonAction(_ sender: UIButton) {
		editUser()
	}
	
	// MARK: Functions
	private func getValues() -> NewUser {
		if userNameTF.text != "" {
			userName = userNameTF.text
		}
		
		if userSurnameTF.text != "" {
			userSurname = userSurnameTF.text
		}
		
		if genreSegmentedControl.selectedSegmentIndex == 0 {
			userGenre = Strings.womanGenre
		} else if genreSegmentedControl.selectedSegmentIndex == 1 {
			userGenre = Strings.manGenre
		} else if genreSegmentedControl.selectedSegmentIndex == 2 {
			userGenre = Strings.otherGenre
		}
		
		if userEmailTF.text != "" {
			userEmail = userEmailTF.text
		}
				
		return NewUser(email: userEmail, password: nil, genre: userGenre, name: userName, surname: userSurname, image: imageUrl)
	}
	
	private func editUser() {
		let editUser = getValues()
		
		NetworkingProvider.shared.modifyData(userModify: editUser) { responseData, status, msg in
			guard let msg = msg else { return }
			
			if status == 1 {
				let indicatorView = SPIndicatorView(title: "Datos Modificados Correctamente", message: msg, preset: .done)
				indicatorView.present(duration: 3)
			} else {
				let indicatorView = SPIndicatorView(title: "Ha ocurrido un error", message: msg, preset: .error)
				indicatorView.present(duration: 3)
			}
		} failure: { error in
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
			vc.modalPresentationStyle = .fullScreen
			vc.modalTransitionStyle = .coverVertical
			vc.errorType = .decodingError
			self.present(vc, animated: true, completion: nil)
		}
	}
	
	// MARK: Styles
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "EDITAR PERFIL"
		
		let yourBackImage = UIImage(systemName: "arrowshape.turn.up.backward.fill", withConfiguration:  UIImage.SymbolConfiguration(pointSize: 18))
		let backButtonItem = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(popView(tapGestureRecognizer:)))
		backButtonItem.tintColor = .corporativeColor
		
		self.navigationItem.leftBarButtonItem = backButtonItem
		
		self.navigationItem.setHidesBackButton(true, animated: true)
	}
	
	private func setTextFieldStyles() {
		// Estilos Name Text Field
		userNameTF.bottomBorder(color: .hardColor ?? .black)
		if let userName = UserDefaultsProvider.shared.string(key: .authUserName) {
			userNameTF.placeholderStyles(placeHolderText: userName)
		} else {
			userNameTF.placeholderStyles(placeHolderText: "Nombre")
		}
		userNameTF.textStyles(keyboardType: .default)
		
		// Estilos Surname Text Field
		userSurnameTF.bottomBorder(color: .hardColor ?? .black)
		if let userSurname = UserDefaultsProvider.shared.string(key: .authUserSurname) {
			userSurnameTF.placeholderStyles(placeHolderText: userSurname)
		} else {
			userSurnameTF.placeholderStyles(placeHolderText: "Apellidos")
		}
		userSurnameTF.textStyles(keyboardType: .default)
		
		// Estilos Email Text Field
		userEmailTF.bottomBorder(color: .hardColor ?? .black)
		if let userEmail = UserDefaultsProvider.shared.string(key: .authUserEmail) {
			userEmailTF.placeholderStyles(placeHolderText: userEmail)
		} else {
			userEmailTF.placeholderStyles(placeHolderText: "Correo Electrónico")
		}
		userEmailTF.textStyles(keyboardType: .default)
	}
	
	private func setButtonStyles() {
		// Estilos Button
		editButton.round()
		editButton.colors()
	}
	
	private func setImageStyles() {
		if let userImage = UserDefaultsProvider.shared.string(key: .authUserImg)  {
			guard let url = URL(string: Constants.kStorageURL + userImage) else { return }
			self.userImageView.loadImage(fromURL: url)
		}
		userImageView.makeRounds()
	}
	
	private func setSegmentedControl() {
		if let userGenre = UserDefaultsProvider.shared.string(key: .authUserGenre) {
			switch userGenre {
			case Strings.womanGenre:
				genreSegmentedControl.selectedSegmentIndex = 0
			case Strings.manGenre:
				genreSegmentedControl.selectedSegmentIndex = 1
			case Strings.otherGenre:
				genreSegmentedControl.selectedSegmentIndex = 2
			default:
				break
			}
		}
	}
	
	@objc func popView(tapGestureRecognizer: UITapGestureRecognizer) {
		self.navigationController?.popViewController(animated: true)
	}
}

extension EditProfileViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true, completion: nil)
		
		let imageUrl = info[.imageURL] as! URL
		
		NetworkingProvider.shared.uploadImage(userImage: imageUrl) { status, msg in
			guard let status = status else { return }
			guard let msg = msg else { return }
			if status == 0 {
				let indicatorView = SPIndicatorView(title: "Ha ocurrido un con la subida de la imagen", message: msg, preset: .error)
				indicatorView.present(duration: 3)
				self.editButton.isEnabled = false
				self.editButton.alpha = 0.5
			} else {
				self.imageUrl = msg
			}
			
		} failure: { error in
			debugPrint("Error \(error.debugDescription)")
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
			vc.modalPresentationStyle = .fullScreen
			vc.modalTransitionStyle = .coverVertical
			vc.errorType = .decodingError
			self.present(vc, animated: true, completion: nil)
		}
		
		userImageView.loadImage(fromURL: imageUrl)
	}
}
