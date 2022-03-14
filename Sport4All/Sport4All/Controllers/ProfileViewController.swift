//
//  ProfileViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 11/2/22.
//

import UIKit

class ProfileViewController: UIViewController {
	
	// MARK: Variables
	private var userImage: String?
	private var userName: String?
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var pendingEventsBTN: UIButton!
	@IBOutlet weak var completedEventsBTN: UIButton!
	@IBOutlet weak var yourClubBTN: UIButton!
	@IBOutlet weak var userImageView: LazyImageView!
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var pendingEventsCollectionView: UICollectionView!
	@IBOutlet weak var finalEventsCollectionView: UICollectionView!
	
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
		
		// Inicialización Collection View
		initCollectionView()
	}
	
	// MARK: Action Functions
	@objc func settingsButtonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		let vc = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
		
		vc.modalPresentationStyle = .automatic
		vc.settingsDelegate = self
		present(vc, animated: true, completion: nil)
	}
	
	@IBAction func yourClubButtonAction(_ sender: UIButton) {
		let vc = UIStoryboard(name: "YourClub", bundle: nil).instantiateViewController(withIdentifier: "YourClub") as! YourClubViewController
		navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: Functions
	private func fetchUserInfo() {
		NetworkingProvider.shared.userInfo { responseData, status, msg in
			guard let userName = responseData?.name else { return }
			guard let userImage = responseData?.image else { return }
			guard let userSurname = responseData?.surname else { return }
			guard let url = URL(string: Constants.kStorageURL + userImage) else { return }
			
			let allUserName = userName + " " + userSurname
			self.userNameLabel.text = allUserName
			
			self.userImageView.loadImage(fromURL: url)
		} failure: { error in
			print(error)
		}
	}
	
	private func initCollectionView(){
		// Pending Events Collection View Cell
		pendingEventsCollectionView.dataSource = self
		pendingEventsCollectionView.delegate = self
		pendingEventsCollectionView.isScrollEnabled = true
		pendingEventsCollectionView.register(UINib.init(nibName: "EventProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventProfileCollectionViewCell")
		pendingEventsCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
		pendingEventsCollectionView.showsVerticalScrollIndicator = false
		pendingEventsCollectionView.showsHorizontalScrollIndicator = false
		pendingEventsCollectionView.reloadData()
		
		// Finish Events Collection View Cell
		finalEventsCollectionView.dataSource = self
		finalEventsCollectionView.delegate = self
		finalEventsCollectionView.isScrollEnabled = true
		finalEventsCollectionView.register(UINib.init(nibName: "EventProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventProfileCollectionViewCell")
		finalEventsCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
		finalEventsCollectionView.showsVerticalScrollIndicator = false
		finalEventsCollectionView.showsHorizontalScrollIndicator = false
		finalEventsCollectionView.reloadData()
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

// MARK: Settings Delegate
extension ProfileViewController: SettingsViewControllerDelegate {
	func settingsViewController(_ settingsViewController: SettingsViewController, didSelectOption option: SettingsOption) {
		let vc = UIStoryboard(name: "EditProfile", bundle: nil).instantiateViewController(withIdentifier: "EditProfile") as! EditProfileViewController
		
		switch option.optionType {
		case .EditProfile:
			self.navigationController?.pushViewController(vc, animated: true)
		case .ContactUs:
			print("Contacta Con Nosotros")
		case .ShowTutorial:
			print("Ver Tutorial")
		case .LogOut:
			print("Cerrar Sesión")
		}
	}
}

// MARK: Pending Events Collection View Delegate and DataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		
		if collectionView == finalEventsCollectionView {
			return 5
		}
		
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventProfileCollectionViewCell", for: indexPath) as? EventProfileCollectionViewCell else { return UICollectionViewCell() }
		return cell
	}
	
	/* Margenes entre las celdas */
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
		return inset
	}
}
