//
//  ProfileViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 11/2/22.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
	
	// MARK: Variables
	private var userImage: String?
	private var userName: String?
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var pendingEventsBTN: UIButton!
	@IBOutlet weak var completedEventsBTN: UIButton!
	@IBOutlet weak var yourClubBTN: UIButton!
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var userNameLabel: UILabel!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Api
		fetchUserInfo()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización Estilos
		headerUIView?.bottomShadow()
		userImageView.makeRounds()
	}
	
	// MARK: Action Functions
	@objc func settingsButtonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		debugPrint("Pulsado")
	}
	
	// MARK: Functions
	private func fetchUserInfo() {
		NetworkingProvider.shared.userInfo { responseData, status, msg in
			guard let userName = responseData?.name else { return }
			guard let userImage = responseData?.image else { return }
			guard let userSurname = responseData?.surname else { return }
			
			let allUserName = userName + " " + userSurname
			self.userNameLabel.text = allUserName
			
			let url = URL(string: Constants.kStorageURL + userImage)
			self.userImageView.kf.setImage(with: url, placeholder: UIImage(named: "Avatar"))
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: Styles
	private func configureNavbar() {
		let hamburguerImage = UIImage(systemName: "line.3.horizontal", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
		let titleLabel = UILabel()
		titleLabel.textColor = .corporativeColor
		titleLabel.font = UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		titleLabel.text = "Perfil"
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: hamburguerImage, style: .plain, target: self, action: #selector(settingsButtonTapped(tapGestureRecognizer: )))

		navigationController?.navigationBar.tintColor = .corporativeColor
	}
}
