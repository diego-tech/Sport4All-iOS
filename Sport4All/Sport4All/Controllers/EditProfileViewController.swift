//
//  EditProfileViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import UIKit

class EditProfileViewController: UIViewController, UINavigationControllerDelegate {

	// MARK: Variables
	private var userName: String?
	private var userSurname: String?
	private var userGenre: String?
	private var imageUrl: String?
	private var userEmail: String?
	
	let pickerController = UIImagePickerController()
	
	// MARK: Outles
	@IBOutlet weak var userImageView: UIImageView!
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
		
		// Init Image Picker Delegate
		pickerController.delegate = self
		
		// Configure Navbar
		configureNavbar()
		
		// Selector Image Init
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		userImageView.isUserInteractionEnabled = true
		userImageView.addGestureRecognizer(tapGestureRecognizer)
		userImageView.makeRounds()
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
			userGenre = "Mujer"
		} else if genreSegmentedControl.selectedSegmentIndex == 1 {
			userGenre = "Hombre"
		} else if genreSegmentedControl.selectedSegmentIndex == 2 {
			userGenre = "Otro"
		}
		
		if userEmailTF.text != "" {
			userEmail = userEmailTF.text
		}

		return NewUser(email: userEmail, password: nil, genre: userGenre, name: userName, surname: userSurname, image: imageUrl)
	}
	
	private func editUser() {
		let editUser = getValues()
		
		NetworkingProvider.shared.modifyData(userModify: editUser) { responseData, status, msg in
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
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
		userNameTF.placeholderStyles(placeHolderText: "Nombre")
		userNameTF.textStyles(keyboardType: .default)
		
		// Estilos Surname Text Field
		userSurnameTF.bottomBorder(color: .hardColor ?? .black)
		userSurnameTF.placeholderStyles(placeHolderText: "Apellidos")
		userSurnameTF.textStyles(keyboardType: .default)
		
		// Estilos Email Text Field
		userEmailTF.bottomBorder(color: .hardColor ?? .black)
		userEmailTF.placeholderStyles(placeHolderText: "Correo Electrónico")
		userEmailTF.textStyles(keyboardType: .default)
	}
	
	private func setButtonStyles() {
		// Estilos Button
		editButton.round()
		editButton.colors()
	}
	
	@objc func popView(tapGestureRecognizer: UITapGestureRecognizer) {
		self.navigationController?.popViewController(animated: true)
	}
}

extension EditProfileViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		picker.dismiss(animated: true, completion: nil)
		
		let image = info[.imageURL] as! URL
		
		NetworkingProvider.shared.uploadImage(userImage: image) { responseData, status, msg in
			print(responseData)
			print(status)
			if let msg = msg {
				self.imageUrl = msg
			}
		} failure: { error in
			print(error)
		}
		
		
		guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
		userImageView.image = image
	}
}
