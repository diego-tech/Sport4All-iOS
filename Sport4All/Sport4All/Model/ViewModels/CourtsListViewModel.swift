//
//  CourtsListViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 12/3/22.
//

import Foundation

class CourtsListViewModel {
	
	// MARK: Variables
	private var courtList = [Court]()
	private var status = Int()

	// MARK: Free Courts List
	func fetchFreeCourts(queryCourt: QueryCourt, completion: @escaping (_ status: Int?, _ error: Error?) -> ()) {
		NetworkingProvider.shared.freeCourts(courtsParameters: queryCourt) { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.courtList = responseList
			if responseList.isEmpty {
				completion(3, nil)
			} else {
				completion(status, nil)
			}
		} failure: { error in
			guard let error = error else { return }
			debugPrint("Free Courts List Error \(error)")
			completion(0, error)
		}
	}
	
	// MARK: DataSource && Delegate Functions Court List
	func numberOfRowsInSection(section: Int) -> Int {
		let section = courtList[section]
		
		if section.isOpened {
			return 2
		} else {
			return 1
		}
	}
	
	func cellForRowAt(indexPath: IndexPath) -> Court {
		return courtList[indexPath.section]
	}
	
	func numberOfSections() -> Int {
		return courtList.count
	}
	
	func reloadSections(indexPath: IndexPath) {
		courtList[indexPath.section].isOpened = !courtList[indexPath.section].isOpened
	}
}
