//
//  FavouriteClubsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 15/2/22.
//

import UIKit

class FavouriteClubsViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var favouritesTableView: UITableView!
	@IBOutlet weak var goBackBTN: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Inicialización Table View
		initTableView()
	}
	
	// MARK: Action Functions
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func initTableView() {
		favouritesTableView.dataSource = self
		favouritesTableView.delegate = self
		favouritesTableView.isScrollEnabled = true
		favouritesTableView.register(UINib(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "ClubTableViewCell")
		favouritesTableView.separatorStyle = .none
		favouritesTableView.showsHorizontalScrollIndicator = false
		favouritesTableView.showsVerticalScrollIndicator = false
	}
	
	// MARK: Styles
}

extension FavouriteClubsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = favouritesTableView.dequeueReusableCell(withIdentifier: "ClubTableViewCell", for: indexPath) as! ClubTableViewCell
		return cell
	}
}
