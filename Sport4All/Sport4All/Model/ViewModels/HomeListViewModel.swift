//
//  ClubListViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import Alamofire
import Foundation

class ListViewModel {
	
	// MARK: Variables
	private var clubList = [Club]()
	private var status = Int()
	public var courtList = [Court]()
	private var priceList = [Price]()
		
	// MARK: Fetch Club List
	func fetchClubList(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.clubList { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.clubList = responseList
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: Fetch Club Favourite List
	func fetchFavouriteClubList(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.clubFavouriteList { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.clubList = responseList
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: Fetch Search Club
	func fetchSearchClub(with query: String, completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.searchClubs(with: query) { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.clubList = responseList
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: Free Courts List
	func fetchFreeCourts(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.freeCourts() { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.courtList = responseList
			print("Court List \(responseList)")
			completion(status)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: DataSource && Delegate Functions Club List
	func numberOfRowsInSection(section: Int) -> Int {
		if clubList.count != 0 {
			return clubList.count
		}
		return 0
	}
	
	func cellForRowAt(indexPath: IndexPath) -> Club {
		return clubList[indexPath.row]
	}
	
	func removeForRowAt(indexPath: IndexPath) {
		clubList.remove(at: indexPath.row)
	}
	
	// MARK: DataSource && Delegate Functions Court List
	func numberOfRowsInSectionCourt(section: Int) -> Int {
		let section = courtList[section]
		
		if section.isOpened {
			return section.prices.count + 1
		} else {
			return 1
		}
	}
	
	func cellForRowAtCourt(indexPath: IndexPath) -> Court {
		return courtList[indexPath.row]
	}
	
	func numberOfSections() -> Int {
		return courtList.count
	}
	
	func reloadSections(indexPath: IndexPath) {
		courtList[indexPath.section].isOpened = !courtList[indexPath.section].isOpened
	}
}
