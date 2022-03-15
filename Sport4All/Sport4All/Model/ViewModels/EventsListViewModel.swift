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
	private var sectionTitles: [String] = [
		"Clubes Favoritos",
		"Otros Clubes"
	]
	
	private var eventList = [Event]()
	private var favEventList = [Event]()	
	private var status = Int()
	
	// MARK: Fetch Events List
	func fetchEventList(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.listEvents { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.eventList = responseList
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: Fetch Fav Events List
	func fetchFavEventsList(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.listEventsByFav { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.favEventList = responseList
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: DataSource && Delegate Functions Event List
	func numberOfSections() -> Int {
		return sectionTitles.count
	}
	
	func numberOfRowInSection(section: Int) -> Int {
		if section == 0 {
			return favEventList.count
		} else {
			return eventList.count
		}
	}
	
	func cellForRowAtEventList(indexPath: IndexPath) -> Event {
		return eventList[indexPath.row]
	}
	
	func cellForRowAtFavEventList(indexPath: IndexPath) -> Event {
		return favEventList[indexPath.row]
	}
	
	func titleForHeaderInSection(section: Int) -> String {
		return sectionTitles[section]
	}
}
