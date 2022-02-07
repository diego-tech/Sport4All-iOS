//
//  HomeViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 7/2/22.
//

import UIKit

class HomeViewController: UIViewController {

	// Outlets
	@IBOutlet weak var interfaceSegmented: CustomHomeSegmentedControl! {
		didSet {
			interfaceSegmented.setButtonTitles(buttonTitles: ["Clubes", "Partidos"])
			interfaceSegmented.selectorViewColor = .hardColor!
			interfaceSegmented.selectorTextColor = .hardColor!
			interfaceSegmented.backgroundColor = .clear
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
