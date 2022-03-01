//
//  SocialViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 1/3/22.
//

import UIKit

class SocialViewController: UIViewController {

	// MARK: Variables
	
	// MARK: Outlets
	
	// MARK: Frame Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
    }
	
	// MARK: Action Functions
	
	
	// MARK: Functions
	
	// MARK: Styles
	private func configureNavbar() {
		// Title Label
		let titleLabel = UILabel()
		titleLabel.textColor = .corporativeColor
		titleLabel.font = UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22)
		titleLabel.text = "Eventos"
		
		// Set Navigation Item
		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
	}
}
