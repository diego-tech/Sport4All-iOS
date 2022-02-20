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
	@IBOutlet weak var bestRatedCollectionView: UICollectionView!
	@IBOutlet weak var homeClubsTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Inicialización Collection View
		initCollectionView()
		
		// Inicialización Table View
		initTableView()
		
		// Custom Search Bar
		searchBar.customSearch()
	}
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func initTableView() {
		homeClubsTableView.dataSource = self
		homeClubsTableView.delegate = self
		homeClubsTableView.isScrollEnabled = true
		homeClubsTableView.register(UINib.init(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "ClubTableViewCell")
		homeClubsTableView.separatorStyle = .none
		homeClubsTableView.showsHorizontalScrollIndicator = false
		homeClubsTableView.showsVerticalScrollIndicator = false
	}
	
	private func initCollectionView() {
		bestRatedCollectionView.dataSource = self
		bestRatedCollectionView.delegate = self
		bestRatedCollectionView.isScrollEnabled = true
		bestRatedCollectionView.register(UINib.init(nibName: "BestRatedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
		bestRatedCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
		bestRatedCollectionView.showsVerticalScrollIndicator = false
		bestRatedCollectionView.showsHorizontalScrollIndicator = false
	}
	
	// MARK: Styles
}

extension HomeClubsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BestRatedCollectionViewCell
		return cell
	}
	
	/* Márgenes entre las celdas */
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
		return inset
	}
}

extension HomeClubsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = homeClubsTableView.dequeueReusableCell(withIdentifier: "ClubTableViewCell") as! ClubTableViewCell
		return cell
	}
}
