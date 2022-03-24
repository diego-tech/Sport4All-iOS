//
//  HomeClubsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/2/22.
//

import UIKit

class HomeClubsViewController: UIViewController {
	
	// MARK: Variables
	private var tableViewModel = HomeListViewModel()
	private var collectionViewModel = HomeCollectionViewModel()
	
	// MARK: Outlets
	@IBOutlet weak var searchBar: UITextField!
	@IBOutlet weak var bestRatedCollectionView: UICollectionView!
	@IBOutlet weak var homeClubsTableView: UITableView!
	@IBOutlet weak var allClubsLabel: UILabel!
	@IBOutlet weak var bestRatedLabel: UILabel!
	@IBOutlet weak var uiViewBestRated: UIView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Set Empty Text in SearchBar when load view
		searchBar.text = ""
		
		// Inicialización Collection View
		mostRatedCollectionList()
		
		// Inicialización Table View
		clubList()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		searchBar.delegate = self
		
		// Init Collection View and Table View
		initCollectionView()
		initTableView()
		
		// Custom Search Bar
		searchBar.customSearch()
		
		// All Clubs Label Action
		allClubsLabel.isUserInteractionEnabled = true
		let tapClubsLabel = UITapGestureRecognizer(target: self, action: #selector(tapClubsLabel(sender:)))
		allClubsLabel.addGestureRecognizer(tapClubsLabel)
		
		// Best Rated Label Action
		bestRatedLabel.isUserInteractionEnabled = true
		let tapBestRatedLabel = UITapGestureRecognizer(target: self, action: #selector(tapBestRatedLabel(sender:)))
		bestRatedLabel.addGestureRecognizer(tapBestRatedLabel)
	}
	
	// MARK: Action Functions
	@objc func tapClubsLabel(sender: UITapGestureRecognizer) {
		DispatchQueue.main.async {
			self.homeClubsTableView.setContentOffset(.zero, animated: true)
		}
	}
	
	@objc func tapBestRatedLabel(sender: UITapGestureRecognizer) {
		DispatchQueue.main.async {
			self.bestRatedCollectionView.setContentOffset(.zero, animated: true)
		}
	}
	
	// MARK: Functions
	private func clubList() {
		tableViewModel.fetchClubList { [weak self] status, error  in
			if error == nil {
				if status == 1 {
					self?.homeClubsTableView.reloadData()
				} else {
					
				}
			} else {
				let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
				vc.modalPresentationStyle = .fullScreen
				vc.modalTransitionStyle = .coverVertical
				vc.errorType = .decodingError
				self?.present(vc, animated: true, completion: nil)
			}
		}
	}
	
	private func mostRatedCollectionList() {
		collectionViewModel.fetchMostRated { [weak self] status, error in
			
			if error == nil {
				if status == 1 {
					self?.bestRatedCollectionView.reloadData()
				} else if status == 3 {
					self?.uiViewBestRated.isHidden = true
				}
			} else {
				let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
				vc.modalPresentationStyle = .fullScreen
				vc.modalTransitionStyle = .coverVertical
				vc.errorType = .decodingError
				self?.present(vc, animated: true, completion: nil)
			}
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
		bestRatedCollectionView.reloadData()
	}
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
		cell.reserveButtonDelegate = self
		cell.alpha = 0
		
		UIView.animate(withDuration: 1.5, animations: { cell.alpha = 1 })
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

// MARK: Best Rated Collection View Cell Delegate
extension HomeClubsViewController: BestRatedCollectionViewCellDelegate{
	func bestRatedCollectionViewCell(_ cell: UICollectionViewCell, club: Club) {
		let vc = UIStoryboard(name: "ReservesScreen", bundle: nil).instantiateViewController(withIdentifier: "ReservesScreen") as! ReservesViewController
		vc.club = club
		navigationController?.pushViewController(vc, animated: true)
	}
}

// MARK: Table View
extension HomeClubsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.numberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubTableViewCell") as? ClubTableViewCell else { return UITableViewCell() }
		let club = tableViewModel.cellForRowAt(indexPath: indexPath)
		cell.setCellWithValueOf(club)
		cell.alpha = 0
		
		UIView.animate(withDuration: 1.5, animations: { cell.alpha = 1 })
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
			tableViewModel.fetchSearchClub(with: query) { [weak self] status, error in
				if error == nil {
					self?.initTableView()
				} else {
					let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
					vc.modalPresentationStyle = .fullScreen
					vc.modalTransitionStyle = .coverVertical
					vc.errorType = .decodingError
					self?.present(vc, animated: true, completion: nil)
				}
			}
		} else {
			clubList()
		}
		return true
	}
}
