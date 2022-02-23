//
//  HomeViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 7/2/22.
//

import UIKit

class HomeViewController: UIViewController {
	
	// Variables

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
	
	@IBAction func favClubButtonAction(_ sender: UIButton) {
		let vc = UIStoryboard(name: "FavouritesClubs", bundle: nil).instantiateViewController(withIdentifier: "FavClub")
		show(vc, sender: self)
	}
	
	@IBAction func testButtonAction(_ sender: UIButton) {
//		let vc = UIStoryboard(name: "InfoClub", bundle: nil).instantiateViewController(withIdentifier: "InfoClub") as! InfoClubViewController
//		let vc = UIStoryboard(name: "DetailEvent", bundle: nil).instantiateViewController(withIdentifier: "DetailEvent") as! DetailEventViewController
//		let vc = UIStoryboard(name: "ModifyPassword", bundle: nil).instantiateViewController(withIdentifier: "ModifyPassword") as! ModifyPasswordViewController
		
		let vc = UIStoryboard(name: "YourClub", bundle: nil).instantiateViewController(withIdentifier: "YourClub") as! YourClubViewController


		show(vc, sender: self)
	}
	
	// MARK: Functions
	
	// MARK: Styles

}
