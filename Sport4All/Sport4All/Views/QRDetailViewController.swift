//
//  QRDetailViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 18/3/22.
//

import UIKit

class QRDetailViewController: UIViewController {
	
	// MARK: Views
	private lazy var dimmedBackgroundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		return view
	}()
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
		imageView.image = UIImage(systemName: "house.fill")
		imageView.backgroundColor = .red
		return imageView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
	
		view.addSubview(dimmedBackgroundView)
		view.addSubview(imageView)
		
		// Dismiss ViewController When Tapped Background
		let gesture = UITapGestureRecognizer(target: self, action:  #selector (backgroundTapped(_:)))
		dimmedBackgroundView.addGestureRecognizer(gesture)
    }
	
	// MARK: Action Functions
	@objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
		print("Hello")
		self.dismiss(animated: true)
	}
}
