//
//  InfoClubViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 15/2/22.
//

import UIKit
import Kingfisher

class InfoClubViewController: UIViewController {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var webContactBTN: UIButton!
	@IBOutlet weak var phoneContactBTN: UIButton!
	@IBOutlet weak var reservBTN: UIButton!
	@IBOutlet weak var clubBannerImageView: UIImageView!
	@IBOutlet weak var clubTitleLabel: UILabel!
	@IBOutlet weak var clubInfoTextView: UITextView!
	@IBOutlet weak var clubServicesStackView: UIStackView!
	@IBOutlet weak var goWebClubButton: UIButton!
	@IBOutlet weak var phoneClubButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure NavBar
		configureNavbar()
		
		// Inicialización Estilos
		buttonStyles()
		headerUIView.bottomShadow()
    }

	// MARK: Action Functions
	
	// MARK: Functions
	func configure(with model: Club) {
		clubTitleLabel.text = model.name
		guard let banner = model.club_banner else { return }
		let url = URL(string: banner)
		clubBannerImageView.kf.setImage(with: url, placeholder: UIImage(named: "InfoClubImg"))
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
