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
	private var pendingSection: [Int] = [0, 1, 2]
	private var pendingEvent = [PendingEvent]()
	private var pendingMatch = [PendingEvent]()
	private var pendingReserve = [PendingEvent]()
	private var status = Int()
	
	// MARK: Fetch Pending Events
	func fetchPendingEvents(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.pendingEvents { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.pendingEvent = responseList
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
			self.pendingMatch = responseList
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
			self.status = status
			self.pendingReserve = responseList
			completion(status)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: DataSource && Delegate Functions Pending Event List
	func numberOfSections() -> Int {
		return pendingSection.count
	}
	
	func numberOfItemsInSection(section: Int) -> Int {
		if section == 0 {
			return pendingEvent.count
		} else if section == 1 {
			return pendingMatch.count
		} else {
			return pendingReserve.count
		}
	}
	
	func cellForItemAtEvent(indexPath: IndexPath) -> PendingEvent {
		return pendingEvent[indexPath.item]
	}
	
	func cellForItemAtMatch(indexPath: IndexPath) -> PendingEvent {
		return pendingMatch[indexPath.item]
	}
	
	func cellForItemAtReserve(indexPath: IndexPath) -> PendingEvent {
		return pendingReserve[indexPath.item]
	}
}
