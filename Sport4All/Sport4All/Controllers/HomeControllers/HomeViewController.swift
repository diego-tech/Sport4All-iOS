//
//  HomeViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 7/2/22.
//

import UIKit

class HomeViewController: UIViewController {
	
	// MARK: Variables

	// MARK: Outlets
	@IBOutlet weak var changeViewSegmentedControl: CustomSegmentedControl!
	@IBOutlet weak var firstVC: UIView!
	@IBOutlet weak var secondVC: UIView!
	
	// MARK: Frame Cycle Functions
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
				
		// Set First View Controller
		firstVC.isHidden = false
		
		// Configure Navbar
		configureNavbar()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		// Segmented Control
		changeViewSegmentedControl.setUpView()
	}
	
	// MARK: Action Functions
	@IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
		changeViewSegmentedControl.changeUnderlinePosition()
		
		firstVC.isHidden = true
		secondVC.isHidden = true

		if changeViewSegmentedControl.selectedSegmentIndex == 0 {
			// Show Home Clubs View Controller
			firstVC.isHidden = false
			secondVC.isHidden = true
		} else if changeViewSegmentedControl.selectedSegmentIndex == 1{
			// Show Home Matches View Controller
			secondVC.isHidden = false
			firstVC.isHidden = true
		}
	}
	
	@objc func startButtonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		let vc = UIStoryboard(name: "FavouritesClubs", bundle: nil).instantiateViewController(withIdentifier: "FavClub") as! FavouriteClubsViewController
		navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: Functions
	
	// MARK: Styles
	private func configureNavbar() {
		// Images and Title Label
		let starImage = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
		let titleLabel = UILabel()
		titleLabel.textColor = .corporativeColor
		titleLabel.font = UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		titleLabel.text = Strings.homeTitle

		// UIBarButtonItem
		let starButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(startButtonTapped(tapGestureRecognizer:)))
		starButtonItem.tintColor = .goldColor
		
		// Set Navigation Items
		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel	)
		self.navigationItem.rightBarButtonItems = [
			starButtonItem
		]
	}
}
