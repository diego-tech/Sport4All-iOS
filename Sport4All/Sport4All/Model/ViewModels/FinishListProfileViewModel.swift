//
//  FinishListProfileViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/3/22.
//

import Foundation
import Alamofire

class FinishListProfileViewModel {
	
	// MARK: Variables
	private var finishSections: [Int] = [0, 1, 2]
	private var finishEvent = [PendingOrFinishEvent]()
	private var finishMatch = [PendingOrFinishEvent]()
	private var finishReserve = [PendingOrFinishEvent]()
	private var status = Int()
	
	// MARK: Fetch Finish Events
	func fetchFinishEvents(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.finishEvents { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.finishEvent = responseList
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: Fetch Finish Matchs
	func fetchFinishMatchs(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.finishMatch { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.finishMatch = responseList
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: Fetch Finish Reserves
	func fetchFinishReserves(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.finishReserve { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.finishReserve = responseList
			completion(status)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: DataSource && Delegate Functions
	func numberOfSections() -> Int {
		return finishSections.count
	}
	
	func numberOfItemsInSection(section: Int) -> Int {
		if section == 0 {
			return finishEvent.count
		} else if section == 1 {
			return finishMatch.count
		} else {
			return finishReserve.count
		}
	}
	
	func cellForItemAtEvent(indexPath: IndexPath) -> PendingOrFinishEvent {
		return finishEvent[indexPath.item]
	}
	
	func cellForItemAtMatch(indexPath: IndexPath) -> PendingOrFinishEvent {
		return finishMatch[indexPath.item]
	}
	
	func cellForItemAtReserve(indexPath: IndexPath) -> PendingOrFinishEvent {
		return finishReserve[indexPath.item]
	}
}
