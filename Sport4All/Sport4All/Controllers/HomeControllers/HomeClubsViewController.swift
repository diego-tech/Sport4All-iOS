//
//  HomeClubsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/2/22.
//

import UIKit

class HomeClubsViewController: UIViewController {

	// Variables
	
	// Outlets
	@IBOutlet weak var searchBar: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		view.backgroundColor = .systemYellow
		// Custom Search Bar
//		searchBar.bottomBorder(color: .hardColor ?? .black)
//		searchBar.placeholderStyles(placeHolderText: "Búsqueda")
//		searchBar.textStyles(keyboardType: .webSearch)
		
		searchBar.customSearch()
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	
	// MARK: Styles
}
