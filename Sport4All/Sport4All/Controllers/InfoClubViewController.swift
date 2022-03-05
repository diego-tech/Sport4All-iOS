//
//  InfoClubViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 15/2/22.
//

import UIKit

class InfoClubViewController: UIViewController {

	// MARK: Variables
	var club: Club?
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var webContactBTN: UIButton!
	@IBOutlet weak var phoneContactBTN: UIButton!
	@IBOutlet weak var reservBTN: UIButton!
	@IBOutlet weak var clubBannerImageView: LazyImageView!
	@IBOutlet weak var clubTitleLabel: UILabel!
	@IBOutlet weak var clubInfoTextView: UITextView!
	@IBOutlet weak var clubServicesStackView: UIStackView!
	@IBOutlet weak var goWebClubButton: UIButton!
	@IBOutlet weak var phoneClubButton: UIButton!
	@IBOutlet weak var addFavouriteButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		configure()
		
		addFavouriteButton.setImage(UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
		
		// Configure NavBar
		configureNavbar()
		
		// Inicialización Estilos
		buttonStyles()
		headerUIView.bottomShadow()
    }

	// MARK: Action Functions
	@IBAction func addToFavouriteButtonAction(_ sender: UIButton) {
		callAddToFavourite()
	}
	
	// MARK: Functions
	func configure() {
		guard let club = club else { return debugPrint("Error Club")}
		guard let banner = club.club_banner else { return debugPrint("Error Banner")}
		guard let url = URL(string: Constants.kStorageURL + banner) else { return debugPrint("Error Url Imagen") }
		guard let description = club.description else { return debugPrint("Error Desc")}
		guard let services = club.services else { return debugPrint("Error Servicios")}
		
		self.clubTitleLabel.text = club.name
		self.clubBannerImageView.loadImage(fromURL: url, placeHolderImage: "HomeLogo")
		self.clubInfoTextView.text = description
		self.clubServicesStackView.setServicesInStackView(services: services, imageSize: CGRect(x: 0, y: 0, width: 50, height: 50))
	}
	
	func callAddToFavourite() {
		guard let id = club?.id else { return }
		NetworkingProvider.shared.registerFavClub(clubId: id) { responseData, status, msg in
			self.addFavouriteButton.setImage(UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18)), for: .normal)
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: Styles
	private func buttonStyles() {
		// Botón Reservar
		reservBTN?.round()
	}
	
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "INFORMACION"
		
		let yourBackImage = UIImage(systemName: "arrowshape.turn.up.backward.fill", withConfiguration:  UIImage.SymbolConfiguration(pointSize: 18))
		let backButtonItem = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(popView(tapGestureRecognizer:)))
		backButtonItem.tintColor = .corporativeColor

		self.navigationItem.leftBarButtonItem = backButtonItem

		self.navigationItem.setHidesBackButton(true, animated: true)
	}
	
	@objc func popView(tapGestureRecognizer: UITapGestureRecognizer) {
		self.navigationController?.popViewController(animated: true)
	}
}
