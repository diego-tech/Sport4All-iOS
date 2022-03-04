//
//  FinishEventDetailViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import UIKit

class FinishEventDetailViewController: UIViewController {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var opinionTextView: UITextView!
	@IBOutlet weak var sendButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización de Estilos
		headerUIView.bottomShadow()
		buttonStyles()
		textViewStyles()
	}
	
	// MARK: Action Functions
	
	
	// MARK: Functions
	
	
	// MARK: Styles
	private func buttonStyles() {
		sendButton.round()
		sendButton.colors()
	}
	
	private func textViewStyles() {
		opinionTextView.layer.borderWidth = 1
		opinionTextView.layer.borderColor = UIColor.hardColor?.cgColor
		opinionTextView.layer.cornerCurve = .circular
		opinionTextView.layer.cornerRadius = 10
		
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.blueLowOpacity,
			NSAttributedString.Key.font: UIFont(name: FontType.SFProRegular.rawValue, size: 14)
		]
		
		opinionTextView.attributedText = NSAttributedString(
			string: "Este evento...",
			attributes: attributes as [NSAttributedString.Key : Any]
		)
	}
	
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "INSCRIPCION"
		
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
