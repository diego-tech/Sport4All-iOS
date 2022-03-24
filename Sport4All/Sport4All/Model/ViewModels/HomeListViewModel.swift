//
//  ClubListViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import Alamofire
import Foundation

class HomeListViewModel {
	
	// MARK: Variables
	private var clubList = [Club]()
	private var status = Int()
		
	// MARK: Fetch Club List
	func fetchClubList(completion: @escaping (_ status: Int?, _ error: Error?) -> ()) {
		NetworkingProvider.shared.clubList { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.clubList = responseList
			if self.clubList.isEmpty {
				completion(3, nil)
			}
			completion(status, nil)
		} failure: { error in
			guard let error = error else { return }
			debugPrint("Fetch Club List Error \(error)")
			completion(0, error)
		}
	}
	
	// MARK: Fetch Club Favourite List
	func fetchFavouriteClubList(completion: @escaping (_ status: Int?, _ error: Error?) -> ()) {
		NetworkingProvider.shared.clubFavouriteList { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.clubList = responseList
			if self.clubList.isEmpty {
				completion(3, nil)
			}
			completion(status, nil)
		} failure: { error in
			guard let error = error else { return }
			debugPrint("Fetch Fav Club List Error \(error)")
			completion(0, error)
		}
	}
	
	// MARK: Fetch Search Club
	func fetchSearchClub(with query: String, completion: @escaping (_ status: Int?, _ error: Error?) -> ()) {
		NetworkingProvider.shared.searchClubs(with: query) { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.clubList = responseList
			if self.clubList.isEmpty {
				completion(3, nil)
			}
			completion(status, nil)
		} failure: { error in
			guard let error = error else { return }
			debugPrint("Fetch Search Club List Error \(error)")
			completion(0, error)
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
}
