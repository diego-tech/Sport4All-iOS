//
//  HomeClubsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/2/22.
//

import UIKit

class HomeClubsViewController: UIViewController {
	
	// MARK: Variables
	private var tableViewModel = ListViewModel()
	private var collectionViewModel = CollectionViewModel()
	
	// MARK: Outlets
	@IBOutlet weak var searchBar: UITextField!
	@IBOutlet weak var bestRatedCollectionView: UICollectionView!
	@IBOutlet weak var homeClubsTableView: UITableView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Set Empty Text in SearchBar when load view
		searchBar.text = ""
		
		// Inicialización Table View
		clubList()
		
		// Inicialización Collection View
		mostRatedCollectionList()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		searchBar.delegate = self
		
		// Custom Search Bar
		searchBar.customSearch()
	}
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func clubList() {
		tableViewModel.fetchClubList { [weak self] status in
			self?.initTableView()
		}
	}
	
	private func mostRatedCollectionList() {
		collectionViewModel.fetchMostRated { [weak self] status in
			self?.initCollectionView()
		}
	}
	
	private func initTableView() {
		homeClubsTableView.dataSource = self
		homeClubsTableView.delegate = self
		homeClubsTableView.isScrollEnabled = true
		homeClubsTableView.register(UINib.init(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "ClubTableViewCell")
		homeClubsTableView.separatorStyle = .none
		homeClubsTableView.showsHorizontalScrollIndicator = false
		homeClubsTableView.showsVerticalScrollIndicator = false
		homeClubsTableView.reloadData()
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

// MARK: Collection View
extension HomeClubsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return collectionViewModel.numberOfItemsInSection(section: section)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BestRatedCollectionViewCell else { return UICollectionViewCell() }
		let club = collectionViewModel.cellForItemAt(indexPath: indexPath)
		cell.setItemWithValueOf(club)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
		
		let club = collectionViewModel.cellForItemAt(indexPath: indexPath)
		let vc = UIStoryboard(name: "InfoClub", bundle: nil).instantiateViewController(withIdentifier: "InfoClub") as! InfoClubViewController
		vc.club = club
		navigationController?.pushViewController(vc, animated: true)
	}
	
	/* Márgenes entre las celdas */
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
		return inset
	}
}

// MARK: Table View
extension HomeClubsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.numberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = homeClubsTableView.dequeueReusableCell(withIdentifier: "ClubTableViewCell") as? ClubTableViewCell else { return UITableViewCell() }
		let club = tableViewModel.cellForRowAt(indexPath: indexPath)
		cell.setCellWithValueOf(club)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let club = tableViewModel.cellForRowAt(indexPath: indexPath)

		let vc = UIStoryboard(name: "InfoClub", bundle: nil).instantiateViewController(withIdentifier: "InfoClub") as! InfoClubViewController
		vc.club = club
		navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK: TextField
extension HomeClubsViewController: UITextFieldDelegate {
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		guard let query = textField.text else { return false }
		
		if query.count >= 3 {
			// Test Search Route
			tableViewModel.fetchSearchClub(with: query) { [weak self] status in
				self?.initTableView()
			}
		} else {
			clubList()
		}
		return true
	}
}
