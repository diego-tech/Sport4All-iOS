//
//  ProfileViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 11/2/22.
//

import UIKit

class ProfileViewController: UIViewController {
	
	// Variables
	
	
	// Outlets
	@IBOutlet weak var headerUIView: UIView?
	@IBOutlet weak var settingsBTN: UIButton?
	@IBOutlet weak var pendingEventsBTN: UIButton?
	@IBOutlet weak var completedEventsBTN: UIButton?
	@IBOutlet weak var yourClubBTN: UIButton?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Inicialización Estilos
		headerUIView?.bottomShadow()
    }
	
	// MARK: Action Buttons

	// MARK: Styles
}
