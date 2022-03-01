//
//  DetailEventViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/2/22.
//

import UIKit

class DetailEventViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var locationBTN: UIButton!
	@IBOutlet weak var inscribeEventBTN: UIButton!
	@IBOutlet weak var headerUIView: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Inicialización Estilos
		locationBTN.contentHorizontalAlignment = .left
		inscribeButtonStyle()
		headerUIView.bottomShadow()
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	
	// MARK: Styles
	private func inscribeButtonStyle() {
		inscribeEventBTN.round()
		inscribeEventBTN.colors()
	}
}
