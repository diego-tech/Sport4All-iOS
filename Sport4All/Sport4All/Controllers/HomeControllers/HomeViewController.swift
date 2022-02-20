//
//  HomeViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 7/2/22.
//

import UIKit

class HomeViewController: UIViewController {
	
	// Variables
	private var segmentedSetUp = false

	// Outlets
	@IBOutlet weak var changeViewSegmentedControl: UISegmentedControl!
	
	@IBOutlet weak var firstVC: UIView!
	@IBOutlet weak var secondVC: UIView!
	
	// MARK: Frame Cycle Functions
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Set First View Controller
		firstVC.isHidden = false
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		if segmentedSetUp == false {
			// Segmented Control
			changeViewSegmentedControl.setUpView()
			segmentedSetUp = true
		}
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
	
	@IBAction func favClubButtonAction(_ sender: UIButton) {
		let vc = UIStoryboard(name: "FavouritesClubs", bundle: nil).instantiateViewController(withIdentifier: "FavClub")
		show(vc, sender: self)
	}
	
	@IBAction func testButtonAction(_ sender: UIButton) {
		let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
		
		vc.modalPresentationStyle = .fullScreen
		show(vc, sender: self)
	}
	
	// MARK: Functions
	
	// MARK: Styles

}
