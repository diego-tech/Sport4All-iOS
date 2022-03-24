//
//  FavouriteClubsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 15/2/22.
//

import UIKit
import SPIndicator

class FavouriteClubsViewController: UIViewController {
	
	// MARK: Variables
	private var clubViewModel = HomeListViewModel()
	
	// MARK: Outlets
	@IBOutlet weak var favouritesTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Inicialización Table View
		clubFavouriteList()
		
		// Configure Navbar
		configureNavbar()
	}
	
	// MARK: Action Functions
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: Functions
	private func clubFavouriteList() {
		clubViewModel.fetchFavouriteClubList { [weak self] status, error in
			if error == nil {
				if status == 1 {
					self?.initTableView()
				} else if status == 3 {
					print("Is Empty")
				} else {
					let indicator = SPIndicatorView(title: "Ha ocurrido un error", preset: .error)
					indicator.present(duration: 2)
				}
			} else {
				self?.goToAuth()
			}
		}
	}
	
	private func initTableView() {
		favouritesTableView.dataSource = self
		favouritesTableView.delegate = self
		favouritesTableView.isScrollEnabled = true
		favouritesTableView.register(UINib.init(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "ClubTableViewCell")
		favouritesTableView.separatorStyle = .none
		favouritesTableView.showsHorizontalScrollIndicator = false
		favouritesTableView.showsVerticalScrollIndicator = false
		favouritesTableView.reloadData()
	}
	
	private func goToAuth() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
		vc.modalPresentationStyle = .fullScreen
		vc.modalTransitionStyle = .coverVertical
		vc.errorType = .decodingError
		present(vc, animated: true, completion: nil)
	}
	
	// MARK: Styles
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = Strings.favTitle
		
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

extension FavouriteClubsViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return clubViewModel.numberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = favouritesTableView.dequeueReusableCell(withIdentifier: "ClubTableViewCell") as? ClubTableViewCell else { return UITableViewCell() }
		let club = clubViewModel.cellForRowAt(indexPath: indexPath)
		
		cell.setCellWithValueOf(club)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let club = clubViewModel.cellForRowAt(indexPath: indexPath)
		
		let vc = UIStoryboard(name: "InfoClub", bundle: nil).instantiateViewController(withIdentifier: "InfoClub") as! InfoClubViewController
		vc.club = club
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		let club = clubViewModel.cellForRowAt(indexPath: indexPath)
		guard let clubId = club.id else { return }
		switch editingStyle {
		case .delete:
			NetworkingProvider.shared.deleteFavouriteClub(clubId: clubId) { [weak self] status, msg in
				guard let status = status else { return }
				if status == 1 {
					self?.clubViewModel.removeForRowAt(indexPath: indexPath)
					tableView.deleteRows(at: [indexPath], with: .left)
				} else {
					let indicator = SPIndicatorView(title: "Ha ocurrido un error", preset: .error)
					indicator.present(duration: 2)
				}
			} failure: { error in
				guard let error = error else { return }
				debugPrint("Delete Favourite FAV VC Error \(error)")
				self.goToAuth()
			}
		default:
			break
		}
	}
	
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		return Strings.titleForDeleteConfirmation
	}
}
