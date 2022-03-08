//
//  MostRatedViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/3/22.
//

import Foundation
import Alamofire

class CollectionViewModel {
	
	// MARK: Variables
	public var clubList = [Club]()
	private var status = Int()
	
	// MARK: Fetch Most Rated
	func fetchMostRated(completion: @escaping (_ status: Int) -> ()) {
		NetworkingProvider.shared.mostRatedList { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.clubList = responseList
			print(responseList)
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	// MARK: DataSource && Delegate Functions
	func numberOfItemsInSection(section: Int) -> Int {
		if clubList.count != 0 {
			return clubList.count
		}
		return 0
	}
	
	func cellForItemAt(indexPath: IndexPath) -> Club {
		return clubList[indexPath.item]
	}
}
