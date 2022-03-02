//
//  YourClubViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class YourClubViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var yourEventsTableView: UITableView!
	@IBOutlet weak var headerUIView: UIView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización de Estilos
		headerUIView.bottomShadow()
		initTableView()
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func initTableView() {
		yourEventsTableView.dataSource = self
		yourEventsTableView.delegate = self
		yourEventsTableView.isScrollEnabled = true
		yourEventsTableView.register(UINib.init(nibName: "YourClubEventsTableViewCell", bundle: nil), forCellReuseIdentifier: "YourClubEventsTBC")
		yourEventsTableView.separatorStyle = .none
		yourEventsTableView.showsHorizontalScrollIndicator = false
		yourEventsTableView.showsVerticalScrollIndicator = false
	}
	
	
	// MARK: Styles
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "TU CLUB"
		
		let yourBackImage = UIImage(systemName: "arrowshape.turn.up.backward.fill", withConfiguration:  UIImage.SymbolConfiguration(pointSize: 18))
		let backButtonItem = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(popView(tapGestureRecognizer:)))
		backButtonItem.tintColor = .corporativeColor

		self.navigationItem.leftBarButtonItem = backButtonItem

		self.navigationItem.setHidesBackButton(true, animated: true)
	}
	
	@objc func popView(tapGestureRecognizer: UITapGestureRecognizer) {
		self.navigationController?.popViewController(animated: true)
	}
}

extension YourClubViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = yourEventsTableView.dequeueReusableCell(withIdentifier: "YourClubEventsTBC") as! YourClubEventsTableViewCell
		return cell
	}
}
