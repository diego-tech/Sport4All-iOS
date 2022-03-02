//
//  EventPendingListViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class EventPendingListViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var pendingEventsList: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Init Table
		pendingEventsList.dataSource = self
		pendingEventsList.delegate = self
		pendingEventsList.isScrollEnabled = true
		pendingEventsList.register(UINib.init(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "ClubTableViewCell")
		pendingEventsList.separatorStyle = .none
		pendingEventsList.showsHorizontalScrollIndicator = false
		pendingEventsList.showsVerticalScrollIndicator = false
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	
	// MARK: Styles
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(.zero, for: .default)
		
		title = "EVENTOS PENDIENTES"
		
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

extension EventPendingListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 15
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = pendingEventsList.dequeueReusableCell(withIdentifier: "ClubTableViewCell") as! ClubTableViewCell
		
		return cell
	}
}
