//
//  EventsViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 12/3/22.
//

import Foundation
import Alamofire

class EventsListViewModel {
	
	// MARK: Variables
	private var eventList = [Event]()
	private var status = Int()
	
	// MARK: Fetch Events List
	func fetchEventList(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.listEvents { responseData, status, msg in
			guard let responseLIst = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.eventList = responseLIst
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: DataSource && Delegate Functions Event List
	func numberOfRowInSection(section: Int) -> Int {
		if eventList.count != 0 {
			return eventList.count
		}
		return 0
	}
	
	func cellForRowAt(indexPath: IndexPath) -> Event {
		return eventList[indexPath.row]
	}
}
