//
//  MatchListViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 17/3/22.
//

import Foundation

class MatchlistViewModel {
	
	// MARK: Variables
	private var matchList = [String: [Match]]()
	private var status = Int()
	
	// MARK: Match List
	func fetchMatchList(completion: @escaping (_ status: Int) -> ()) {
		NetworkingProvider.shared.matches { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.matchList = responseList
			print(responseList)
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: DataSource && Delegate Functions MatchList
	func numberOfRowsInSection(section: Int) -> Int {
//		let section = ma
//
//		if section.isOpened {
//			return section	.
//		}
		
		return 1
	}
	
//	func cellForRowAt(indexPath: IndexPath) -> [Match] {
//		return matchList[indexPath.row]
//	}
}

