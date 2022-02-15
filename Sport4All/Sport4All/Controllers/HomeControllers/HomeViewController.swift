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
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	
	@IBOutlet weak var firstVC: UIView!
	@IBOutlet weak var secondVC: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Set First View Controller
		firstVC.isHidden = false
		
		// Segmented Control
		segmentedControl.setUpView()
	}
	
	// MARK: Action Functions
	@IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
		segmentedControl.changeUnderlinePosition()
		
		firstVC.isHidden = true
		secondVC.isHidden = true

		if segmentedControl.selectedSegmentIndex == 0 {
			// Show Home Clubs View Controller
			firstVC.isHidden = false
			secondVC.isHidden = true
		} else if segmentedControl.selectedSegmentIndex == 1{
			// Show Home Matches View Controller
			secondVC.isHidden = false
			firstVC.isHidden = true
		}
	}
	
	@IBAction func favClubButtonAction(_ sender: UIButton) {
		let vc = UIStoryboard(name: "FavouritesClubs", bundle: nil).instantiateViewController(withIdentifier: "FavClub")
		show(vc, sender: self)
	}
	
	@IBAction func testButtonAction(_ sender: Any) {
		let vc = UIStoryboard(name: "InfoClub", bundle: nil).instantiateViewController(withIdentifier: "InfoClub")
		show(vc, sender: self)
	}
	
	// MARK: Functions
	
	// MARK: Styles

}
