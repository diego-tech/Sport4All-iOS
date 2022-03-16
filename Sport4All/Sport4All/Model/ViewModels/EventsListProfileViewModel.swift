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
	private var eventList = [Event]()
	private var status = Int()
	
	// MARK: Fetch Pending Events
	func fetchPendingEvents(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.pendingEvents { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.eventList = responseList
			completion(status)
		} failure: { error in
			print(error)
		}
	}
	
	// MARK: DataSource && Delegate Functions Pending Event List
	func numberOfItemsInSection(section: Int) -> Int {
		if eventList.count != 0 {
			return eventList.count
		}
		
		return 0
	}
	
	func cellForItemAt(indexPath: IndexPath) -> Event {
		return eventList[indexPath.item]
	}
}
