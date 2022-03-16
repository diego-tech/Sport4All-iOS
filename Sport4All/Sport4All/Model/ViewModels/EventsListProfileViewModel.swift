//
//  EventsListProfileViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import Foundation
import Alamofire

class EventsListProfileViewModel {
	
	// MARK: Variables
	private var matchList = [PendingMatch]()
	private var matchListSort = [PendingMatch]()
	private var status = Int()
	
	// MARK: Fetch Pending Events
	func fetchPendingEvents(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.pendingEvents { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			dump(responseList)
			self.status = status
			self.matchList += responseList
			completion(status)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: Fetch Pending Matches
	func fetchPendingMatches(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.pendingMatches { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.matchList += responseList
			completion(status)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: Fetch Pending Reserves
	func fetchPendingReserves(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.pendingReserves { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.matchList += responseList
			self.status = status
			completion(status)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: Functions
	func sortArray() {
		let today = Date()
		let df = DateFormatter()
		df.dateFormat = "yyyy-MM-dd"
		let todayFormat = df.string(from: today)
		
		// let sortedArray = array.sorted {$0.compare($1, options: .numeric) == .orderedDescending}

	}
	
	// MARK: DataSource && Delegate Functions Pending Event List
	func numberOfItemsInSection(section: Int) -> Int {
		if matchListSort.count != 0 {
			return matchListSort.count
		}
		
		return 0
	}
	
	func cellForItemAt(indexPath: IndexPath) -> PendingMatch {
		return matchList[indexPath.item]
	}
}