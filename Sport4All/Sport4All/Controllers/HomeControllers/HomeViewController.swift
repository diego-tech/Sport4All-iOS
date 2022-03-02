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
	@IBOutlet weak var changeViewSegmentedControl: UISegmentedControl!
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
		let vc = UIStoryboard(name: "FavouritesClubs", bundle: nil).instantiateViewController(withIdentifier: "FavClub")
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc func locationButtonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		let vc = UIStoryboard(name: "InfoClub", bundle: nil).instantiateViewController(withIdentifier: "InfoClub") as! InfoClubViewController
//		let vc = UIStoryboard(name: "DetailEvent", bundle: nil).instantiateViewController(withIdentifier: "DetailEvent") as! DetailEventViewController
//		let vc = UIStoryboard(name: "ModifyPassword", bundle: nil).instantiateViewController(withIdentifier: "ModifyPassword") as! ModifyPasswordViewController
//		let vc = UIStoryboard(name: "YourClub", bundle: nil).instantiateViewController(withIdentifier: "YourClub") as! YourClubViewController
//		let vc = UIStoryboard(name: "PendingEventsDetail", bundle: nil).instantiateViewController(withIdentifier: "PendingEvents") as! PendingEventsViewController
		
//		let vc = UIStoryboard(name: "PayResume", bundle: nil).instantiateViewController(withIdentifier: "PayResume") as! PayResumeViewController
//		let vc = UIStoryboard(name: "EventPendingList", bundle: nil).instantiateViewController(withIdentifier: "EventPendingList") as! EventPendingListViewController
//		let vc = UIStoryboard(name: "EditProfile", bundle: nil).instantiateViewController(withIdentifier: "EditProfile") as! EditProfileViewController
//		let vc = UIStoryboard(name: "RegisterInEvent", bundle: nil).instantiateViewController(withIdentifier: "RegisterInEvent") as! RegisterInEventViewController
//		let vc = UIStoryboard(name: "FinishEventDetail", bundle: nil).instantiateViewController(withIdentifier: "FinishEventDetail") as! FinishEventDetailViewController
		
		navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: Functions
	
	// MARK: Styles
	private func configureNavbar() {
		// Images and Title Label
		let locationImage = UIImage(systemName: "location.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))

		let starImage = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
		let titleLabel = UILabel()
		titleLabel.textColor = .corporativeColor
		titleLabel.font = UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22)
		titleLabel.text = "Inicio"

		// UIBarButtonItem
		let locationButtonItem = UIBarButtonItem(image: locationImage, style: .plain, target: self, action: #selector(locationButtonTapped(tapGestureRecognizer:)))
		locationButtonItem.tintColor = .corporativeColor
		
		let starButtonItem = UIBarButtonItem(image: starImage, style: .plain, target: self, action: #selector(startButtonTapped(tapGestureRecognizer:)))
		starButtonItem.tintColor = .goldColor
		
		// Set Navigation Items
		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
		self.navigationItem.rightBarButtonItems = [
			starButtonItem,
			locationButtonItem
		]
	}
}
