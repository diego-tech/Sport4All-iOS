//
//  ViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var exampleLabel: UILabel!
		
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	
		exampleLabel.font = UIFont(name: FontType.SFProBold.rawValue, size: 12)
	}
}

