//
//  CourtsListViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 12/3/22.
//

import Foundation

class CourtsListViewModel {
	
	private var courtList = [Court]()
	private var status = Int()

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
