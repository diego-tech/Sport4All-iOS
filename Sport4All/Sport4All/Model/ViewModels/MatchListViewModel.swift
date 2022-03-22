//
//  MatchListViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 17/3/22.
//

import Foundation

class MatchlistViewModel {
	
	// MARK: Variables
	private var matchList = [Match]()
	private var status = Int()
	
	// MARK: Match List
	func fetchMatchList(day: String, completion: @escaping (_ status: Int, _ error: Error?) -> ()) {
		NetworkingProvider.shared.matches(day: day) { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.matchList = responseList
			completion(status, nil)
		} failure: { error in
			completion(0, error)
		}
	}
	
	// MARK: DataSource && Delegate Functions MatchList
	func numberOfRowsInSection(section: Int) -> Int {
		let section = matchList[section]
		
		if section.isOpened {
			return section.items!.count + 1
		}
		
		return 1
	}
	
	func cellForRowAt(indexPath: IndexPath) -> Match {
		return matchList[indexPath.section]
	}
	
	func numberOfSections() -> Int {
		return matchList.count
	}
	
	func reloadSections(indexPath: IndexPath) {
		matchList[indexPath.section].isOpened = !matchList[indexPath.section].isOpened
	}
}

