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
}
