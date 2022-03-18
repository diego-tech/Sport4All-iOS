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
	
	private var collectionViewModel = EventsListProfileViewModel()
	
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
			
		// Inicialización Collection View
		self.pendingList()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Pending Collection View Initialization
		initPendingCollectionView()
		
		// Inicialización Estilos
		headerUIView?.bottomShadow()
		userImageView.makeRounds()
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
	
	private func pendingList() {
		self.pendingEventsCollectionView.dataSource = self
		self.pendingEventsCollectionView.delegate = self
		
		collectionViewModel.fetchPendingEvents { [weak self] status in
//			self?.pendingEventsCollectionView.reloadData()
		}

		collectionViewModel.fetchPendingMatches { [weak self] status in
//			self?.pendingEventsCollectionView.reloadData()
		}

		collectionViewModel.fetchPendingReserves { [weak self] status in
			self?.pendingEventsCollectionView.reloadData()
		}
	}
	
	private func initPendingCollectionView(){
		// Pending Events Collection View Cell
		pendingEventsCollectionView.isScrollEnabled = true
		pendingEventsCollectionView.register(UINib.init(nibName: "EventProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventProfileCollectionViewCell")
		pendingEventsCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
		pendingEventsCollectionView.showsVerticalScrollIndicator = false
		pendingEventsCollectionView.showsHorizontalScrollIndicator = false
	}
	
	private func initFinishCollectionView() {
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
		if collectionView == pendingEventsCollectionView {
			return collectionViewModel.numberOfItemsInSection(section: section)
		}
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventProfileCollectionViewCell", for: indexPath) as? EventProfileCollectionViewCell else { return UICollectionViewCell() }
		
		if collectionView == pendingEventsCollectionView {
			let pendingEvent = collectionViewModel.cellForItemAt(indexPath: indexPath)
			
			switch pendingEvent.pendingType {
			case PendingType.event.rawValue:
				cell.setItemWithValueOf(pendingEvent, pendingType: .event)
			case PendingType.match.rawValue:
				cell.setItemWithValueOf(pendingEvent, pendingType: .match)
			case PendingType.reserve.rawValue:
				cell.setItemWithValueOf(pendingEvent, pendingType: .reserve)
			default:
				break
			}
		}
		
		return cell
	}
	
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		
		if collectionView == pendingEventsCollectionView {
			let pendingEvent = collectionViewModel.cellForItemAt(indexPath: indexPath)
			
			switch pendingEvent.pendingType {
			case PendingType.event.rawValue:
				let vc = UIStoryboard(name: "PendingEventsDetail", bundle: nil).instantiateViewController(withIdentifier: "PendingEvents") as! PendingEventsViewController
				vc.pendingEvent = pendingEvent
				vc.pendingType = .event
				self.navigationController?.pushViewController(vc, animated: true)
			case PendingType.match.rawValue:
				let vc = UIStoryboard(name: "PendingEventsDetail", bundle: nil).instantiateViewController(withIdentifier: "PendingEvents") as! PendingEventsViewController
				vc.pendingEvent = pendingEvent
				vc.pendingType = .match
				self.navigationController?.pushViewController(vc, animated: true)
			case PendingType.reserve.rawValue:
				let vc = UIStoryboard(name: "PendingEventsDetail", bundle: nil).instantiateViewController(withIdentifier: "PendingEvents") as! PendingEventsViewController
				vc.pendingEvent = pendingEvent
				vc.pendingType = .reserve
				self.navigationController?.pushViewController(vc, animated: true)
			default:
				break
			}
		}
	}
	
	/* Margenes entre las celdas */
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let inset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
		return inset
	}
}
