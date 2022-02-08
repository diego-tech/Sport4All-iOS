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
	@IBOutlet weak var searchBar: UITextField!
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	
	@IBOutlet weak var firstVC: UIView!
	@IBOutlet weak var secondVC: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// MARK: REFACTOR TO EXTENSION
		
		let bottomLine = UIView()
		
		searchBar.borderStyle = .none
		bottomLine.translatesAutoresizingMaskIntoConstraints = false
		bottomLine.backgroundColor = .hardColor
		
		searchBar.addSubview(bottomLine)
		bottomLine.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1).isActive = true
		bottomLine.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor).isActive = true
		bottomLine.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor).isActive = true
		bottomLine.heightAnchor.constraint(equalToConstant: 1.5).isActive = true

		searchBar.placeholderRect(forBounds: CGRect(x: -3.0, y: 0, width: 0, height: 0))
		searchBar.placeholderStyles(placeHolderText: "Búsqueda")
		searchBar.textStyles(keyboardType: .default)
		
		let image = UIImageView()
		let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .medium, scale: .unspecified)
		let searchUImage = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfiguration)
		image.image = searchUImage
		
		let contentView = UIView()
		contentView.addSubview(image)
		contentView.frame = CGRect(x: 0.0, y: 0.0, width: searchUImage!.size.width, height: searchUImage!.size.height)
		image.frame = CGRect(x: -2.0, y: 0.0, width: searchUImage!.size.width, height: searchUImage!.size.height)
		searchBar.leftView = contentView
		searchBar.leftViewMode = .always
		
		
		// Segmented Control
		segmentedControl.addUnderlineForSelectedSegment()
	}
	
	// MARK: Action Functions
	@IBAction func segmentedControlAction(_ sender: Any) {
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
	
	// MARK: Functions
	
	// MARK: Styles

}
