//
//  PayResumeViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class PayResumeViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var button: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
	
	override func updateViewConstraints() {
		let height: CGFloat = 550
		self.view.frame.size.height = height
		self.view.frame.origin.y = UIScreen.main.bounds.height - height
		self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
		super.updateViewConstraints()
	}
	
	// MARK: Action Functions
	@IBAction func selectTypePay(_ sender: UIButton) {
		let typePayMenu = UIMenu(title: "", children: [
			UIAction(title: "Tarjeta", image: UIImage(systemName: "creditcard")){
				action in
				// Copy
			},
			UIAction(title: "Apple Pay", image: UIImage(systemName: "applelogo")) {
				action in
				// Rename
			},
			UIAction(title: "PayPal", image: UIImage(systemName: "plus.square.on.square")) {
				action in
				// Duplicate
			}
		])
		button.tintColor = .hardColor
		button.menu = typePayMenu
		button.showsMenuAsPrimaryAction = true
	}
	
	// MARK: Functions
	
	
	// MARK: Styles
	private func setUpButtonItem() {
		let typePayMenu = UIMenu(title: "", children: [
			UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc")){
				action in
				// Copy
			},
			UIAction(title: "Rename", image: UIImage(systemName: "pencil")) {
				action in
				// Rename
			},
			UIAction(title: "Duplicate", image: UIImage(systemName: "plus.square.on.square")) {
				action in
				// Duplicate
			},
			UIAction(title: "Move", image: UIImage(systemName: "folder")) {
				action in
				// Move
			}
		])
	}
}
