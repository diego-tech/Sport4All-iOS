//
//  ProfileViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 11/2/22.
//

import UIKit
import SPIndicator

enum ProfilesSections: Int {
	case Event = 0
	case Match = 1
	case Reserve = 2
}

class ProfileViewController: UIViewController {
	
	// MARK: Variables
	private var userImage: String?
	private var userName: String?
	
	private var pendingCollectionViewModel = PendingListProfileViewModel()
	private var finishCollectionViewModel = FinishListProfileViewModel()
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
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
		self.finishList()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Collection View Initialization
		initPendingCollectionView()
		initFinishCollectionView()
		
		// Inicialización Estilos
		headerUIView?.bottomShadow()
		userImageView.makeRounds()
	}
	
	// MARK: Action Functions
	@objc func settingsButtonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		let vc = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
		vc.settingsDelegate = self
		present(vc, animated: true, completion: nil)
	}
	
	@IBAction func yourClubButtonAction(_ sender: UIButton) {
		// Upcoming View
		//		let vc = UIStoryboard(name: "YourClub", bundle: nil).instantiateViewController(withIdentifier: "YourClub") as! YourClubViewController
		//		navigationController?.pushViewController(vc, animated: true)
		
		/*
		 let image = UIImage.init(systemName: "sun.min.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
		 SPIndicator.present(title: "Custom Image", message: "With tint color", preset: .custom(image)))
		 */
		
		let image = UIImage.init(systemName: "exclamationmark.icloud")!.withTintColor(.red, renderingMode: .alwaysOriginal)
		let indicatorView = SPIndicatorView(title: "En desarrollo", preset: .custom(image))
		indicatorView.present(duration: 3)
	}
	
	// MARK: Functions
	private func fetchUserInfo() {
		NetworkingProvider.shared.userInfo { responseData, status, msg in
			if status == 1 {
				guard let userEmail = responseData?.email else { return }
				if let userName = responseData?.name, let userSurname = responseData?.surname {
					self.userNameLabel.text = userName + " " + userSurname
				} else {
					self.userNameLabel.text = userEmail
				}
				
				if let userImage = responseData?.image  {
					guard let url = URL(string: Constants.kStorageURL + userImage) else { return }
					self.userImageView.loadImage(fromURL: url)
				}
			}
		} failure: { error in
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
			vc.modalPresentationStyle = .fullScreen
			vc.modalTransitionStyle = .coverVertical
			vc.errorType = .decodingError
			print("Error 1")
			self.present(vc, animated: true, completion: nil)
		}
	}
	
	private func pendingList() {
		self.pendingEventsCollectionView.dataSource = self
		self.pendingEventsCollectionView.delegate = self
		
		pendingCollectionViewModel.fetchPendingEvents { [weak self] status in
			self?.pendingEventsCollectionView.reloadData()
		}
		
		pendingCollectionViewModel.fetchPendingMatches { [weak self] status in
			self?.pendingEventsCollectionView.reloadData()
		}
		
		pendingCollectionViewModel.fetchPendingReserves { [weak self] status in
			self?.pendingEventsCollectionView.reloadData()
		}
	}
	
	private func finishList() {
		self.finalEventsCollectionView.dataSource = self
		self.finalEventsCollectionView.delegate = self
		
		finishCollectionViewModel.fetchFinishEvents { [weak self] status in
			self?.finalEventsCollectionView.reloadData()
		}
		
		finishCollectionViewModel.fetchFinishMatchs { [weak self] status in
			self?.finalEventsCollectionView.reloadData()
		}
		
		finishCollectionViewModel.fetchFinishReserves { [weak self] status in
			self?.finalEventsCollectionView.reloadData()
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
		finalEventsCollectionView.isScrollEnabled = true
		finalEventsCollectionView.register(UINib.init(nibName: "EventProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EventProfileCollectionViewCell")
		finalEventsCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
		finalEventsCollectionView.showsVerticalScrollIndicator = false
		finalEventsCollectionView.showsHorizontalScrollIndicator = false
	}
	
	private func logOut() {
		NetworkingProvider.shared.logOut { status, msg in
			guard let msg = msg else { return }
			
			if status == 1 {
				let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
				vc.modalPresentationStyle = .fullScreen
				vc.modalTransitionStyle = .coverVertical
				vc.isModalInPresentation = true
				self.present(vc, animated: true, completion: nil)
			} else {
				let indicator = SPIndicatorView(title: "Ha ocurrido un error", message: msg, preset: .error)
				indicator.present(duration: 2)
			}
		} failure: { error in
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
			vc.modalPresentationStyle = .fullScreen
			vc.modalTransitionStyle = .coverVertical
			vc.errorType = .decodingError
			self.present(vc, animated: true, completion: nil)
		}
	}
	
	private func goToOnboarding() {
		let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
		vc.modalPresentationStyle = .fullScreen
		vc.modalTransitionStyle = .coverVertical
		vc.modalType = .showTutorial
		present(vc, animated: true, completion: nil)
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
			if let urlToOpen = URL(string: Constants.kContactUsWeb) {
				UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil )
			}
		case .ShowTutorial:
			self.goToOnboarding()
		case .LogOut:
			self.logOut()
			UserDefaultsProvider.shared.remove(key: .authUserToken)
		}
	}
}

// MARK: Pending Events Collection View Delegate and DataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		if collectionView == pendingEventsCollectionView {
			return pendingCollectionViewModel.numberOfSections()
		} else {
			return finishCollectionViewModel.numberOfSections()
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == pendingEventsCollectionView {
			return pendingCollectionViewModel.numberOfItemsInSection(section: section)
		} else {
			return finishCollectionViewModel.numberOfItemsInSection(section: section)
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventProfileCollectionViewCell", for: indexPath) as? EventProfileCollectionViewCell else { return UICollectionViewCell() }
		
		if collectionView == pendingEventsCollectionView {
			switch indexPath.section {
			case ProfilesSections.Event.rawValue:
				let pendingEvent = pendingCollectionViewModel.cellForItemAtEvent(indexPath: indexPath)
				cell.setItemWithValueOf(pendingEvent, pendingType: .event)
			case ProfilesSections.Match.rawValue:
				let pendingMatch = pendingCollectionViewModel.cellForItemAtMatch(indexPath: indexPath)
				cell.setItemWithValueOf(pendingMatch, pendingType: .match)
			case ProfilesSections.Reserve.rawValue:
				let pendingReserve = pendingCollectionViewModel.cellForItemAtReserve(indexPath: indexPath)
				cell.setItemWithValueOf(pendingReserve, pendingType: .reserve)
			default:
				break
			}
		} else {
			switch indexPath.section {
			case ProfilesSections.Event.rawValue:
				let finishEvent = finishCollectionViewModel.cellForItemAtEvent(indexPath: indexPath)
				cell.setItemWithValueOf(finishEvent, pendingType: .event)
			case ProfilesSections.Match.rawValue:
				let finishMatch = finishCollectionViewModel.cellForItemAtMatch(indexPath: indexPath)
				cell.setItemWithValueOf(finishMatch, pendingType: .match)
			case ProfilesSections.Reserve.rawValue:
				let finishReserve = finishCollectionViewModel.cellForItemAtReserve(indexPath: indexPath)
				cell.setItemWithValueOf(finishReserve, pendingType: .reserve)
			default:
				break
			}
		}
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		
		if collectionView == pendingEventsCollectionView {
			let vc = UIStoryboard(name: "PendingEventsDetail", bundle: nil).instantiateViewController(withIdentifier: "PendingEvents") as! PendingEventsViewController
			switch indexPath.section {
			case ProfilesSections.Event.rawValue:
				let pendingEvent = pendingCollectionViewModel.cellForItemAtEvent(indexPath: indexPath)
				vc.pendingType = .event
				vc.pendingEvent = pendingEvent
				self.navigationController?.pushViewController(vc
															  , animated: true)
			case ProfilesSections.Match.rawValue:
				let pendingMatch = pendingCollectionViewModel.cellForItemAtMatch(indexPath: indexPath)
				vc.pendingType = .match
				vc.pendingEvent = pendingMatch
				self.navigationController?.pushViewController(vc
															  , animated: true)
			case ProfilesSections.Reserve.rawValue:
				let pendingReserve = pendingCollectionViewModel.cellForItemAtReserve(indexPath: indexPath)
				vc.pendingType = .reserve
				vc.pendingEvent = pendingReserve
				self.navigationController?.pushViewController(vc
															  , animated: true)
			default:
				break
			}
		} else {
			let vc = UIStoryboard(name: "FinishEventDetail", bundle: nil).instantiateViewController(withIdentifier: "FinishEventDetail") as! FinishEventDetailViewController
			switch indexPath.section {
			case ProfilesSections.Event.rawValue:
				let finishEvent = finishCollectionViewModel.cellForItemAtEvent(indexPath: indexPath)
				vc.pendingEvent = finishEvent
				self.navigationController?.pushViewController(vc, animated: true)
			case ProfilesSections.Match.rawValue:
				let finishMatch = finishCollectionViewModel.cellForItemAtMatch(indexPath: indexPath)
				vc.pendingEvent = finishMatch
				self.navigationController?.pushViewController(vc, animated: true)
			case ProfilesSections.Reserve.rawValue:
				let finisReserve = finishCollectionViewModel.cellForItemAtReserve(indexPath: indexPath)
				vc.pendingEvent = finisReserve
				self.navigationController?.pushViewController(vc, animated: true)
			default:
				break
			}
		}
	}
}
