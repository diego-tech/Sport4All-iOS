//
//  PendingListProfileViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import Foundation
import Alamofire

class PendingListProfileViewModel {
	
	// MARK: Variables
	private var pendingSections: [Int] = [0, 1, 2]
	private var pendingEvent = [PendingOrFinishEvent]()
	private var pendingMatch = [PendingOrFinishEvent]()
	private var pendingReserve = [PendingOrFinishEvent]()
	private var status = Int()
	
	// MARK: Fetch Pending Events
	func fetchPendingEvents(completion: @escaping (_ status: Int?, _ error: Error?) -> ()) {
		NetworkingProvider.shared.pendingEvents { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.pendingEvent = responseList
			if responseList.isEmpty {
				completion(3, nil)
			} else {
				completion(status, nil)
			}
		} failure: { error in
			guard let error = error else { return }
			debugPrint("Pending Events List Error \(error)")
			completion(0, error)
		}
	}
	
	// MARK: Fetch Pending Matches
	func fetchPendingMatches(completion: @escaping (_ status: Int?, _ error: Error?) -> ()) {
		NetworkingProvider.shared.pendingMatches { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.pendingMatch = responseList
			if responseList.isEmpty {
				completion(3, nil)
			} else {
				completion(status, nil)
			}
		} failure: { error in
			guard let error = error else { return }
			debugPrint("Pending Matches List Error \(error)")
			completion(0, error)
		}
	}
	
	// MARK: Fetch Pending Reserves
	func fetchPendingReserves(completion: @escaping (_ status: Int?, _ error: Error?) -> ()) {
		NetworkingProvider.shared.pendingReserves { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.pendingReserve = responseList
			if responseList.isEmpty {
				completion(3, nil)
			} else {
				completion(status, nil)
			}
		} failure: { error in
			guard let error = error else { return }
			debugPrint("Pending Reserves List Error \(error)")
			completion(0, error)
		}
	}
	
	// MARK: DataSource && Delegate Functions
	func numberOfSections() -> Int {
		return pendingSections.count
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
	
	func cellForItemAtEvent(indexPath: IndexPath) -> PendingOrFinishEvent {
		return pendingEvent[indexPath.item]
	}
	
	func cellForItemAtMatch(indexPath: IndexPath) -> PendingOrFinishEvent {
		return pendingMatch[indexPath.item]
	}
	
	func cellForItemAtReserve(indexPath: IndexPath) -> PendingOrFinishEvent {
		return pendingReserve[indexPath.item]
	}
}
